package com.aeltumn.realms.crossfire.functions

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.crossfire.CrossfireScoreboards
import com.aeltumn.realms.crossfire.CrossfireTags
import com.aeltumn.realms.crossfire.References
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.chatcomponents.entityComponent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.literals.tag
import io.github.ayfri.kore.arguments.types.resources.EffectArgument
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.clear
import io.github.ayfri.kore.commands.effect
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.functions.tick
import io.github.ayfri.kore.generated.Sounds

/** Sets up water touch handling. */
public object TouchWater {

    /** Configures water touch handling. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            tick("check_water_touch") {
                execute {
                    asTarget(
                        allPlayers {
                            tag(CrossfireTags.JOINED)
                            tag("!${CrossfireTags.DIED_IN_WATER}")
                            tag("!${CrossfireTags.ADMIN}")
                        }
                    )
                    at(self())
                    ifCondition {
                        block(AT_POSITION, io.github.ayfri.kore.arguments.types.resources.block("water"))
                    }

                    run {
                        // Send {player} tried to swim..
                        for ((index, _) in References.MAPS.withIndex()) {
                            execute {
                                ifCondition {
                                    score(self(), CrossfireScoreboards.TARGET_MAP_INDEX) equalTo index
                                }

                                run {
                                    tellraw(
                                        allEntities {
                                            scores {
                                                score(CrossfireScoreboards.TARGET_MAP_INDEX, index)
                                            }
                                        },
                                        entityComponent("@s").plus(textComponent(" tried to swim.."))
                                    )
                                }
                            }
                        }

                        // Reset the player's state to prepare them for spectating
                        clear(self(), item("leather_chestplate"))
                        clear(self(), item("leather_leggings"))
                        clear(self(), item("leather_boots"))
                        tag(self()) {
                            add(CrossfireTags.DIED_IN_WATER)
                            add(CrossfireTags.SPECTATING)
                            add(CrossfireTags.DIED)
                        }
                        effect(self()) {
                            giveInfinite(EffectArgument("levitation"), 255, true)
                            giveInfinite(EffectArgument("invisibility"), 255, true)
                        }

                        // Reduce kills by 1
                        scoreboard.players.remove(self(), CrossfireScoreboards.ROUND_KILLS, 1)

                        // Remove 1 from the kills of the player's team's visual score
                        for (teamName in References.TEAM_NAMES) {
                            execute {
                                ifCondition {
                                    entity(
                                        self {
                                            team = teamName
                                        }
                                    )
                                }

                                run {
                                    scoreboard.players.remove(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.KILLS, 1)
                                }
                            }
                        }

                        // Add an action bar message
                        title(self(), TitleLocation.ACTIONBAR, textComponent("A point has been taken away because you fell in the water.", Color.RED))

                        // Play a sound effect
                        playSound(Sounds.Liquid.SPLASH, PlaySoundMixer.PLAYER, self(), AT_POSITION, 2.0, 1.0)
                    }
                }
            }
        }
    }
}