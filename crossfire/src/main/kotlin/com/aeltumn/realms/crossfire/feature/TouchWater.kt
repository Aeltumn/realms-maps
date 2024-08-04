package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.playSound
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.feature.Spectating.ENTER_SPECTATING_FUNCTION
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.chatcomponents.entityComponent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title

/** Sets up water touch handling. */
public object TouchWater : Configurable {

    override fun DataPack.configure() {
        tick("check_water_touch") {
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.JOINED
                        tag = !CrossfireTags.DIED
                        tag = !CrossfireTags.DIED_IN_WATER
                    }
                )
                at(self())
                ifCondition {
                    block(AT_POSITION, io.github.ayfri.kore.arguments.types.resources.block("water"))
                }

                run {
                    // Send {player} tried to swim
                    for ((index, _) in References.MAPS.withIndex()) {
                        execute {
                            ifCondition {
                                score(self(), CrossfireScoreboards.TARGET_MAP_INDEX) equalTo index
                            }

                            run {
                                tellraw(
                                    allPlayers {
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
                    tag(self()) {
                        add(CrossfireTags.DIED_IN_WATER)
                        add(CrossfireTags.DIED)
                    }

                    // Start spectating for the player
                    function(References.NAMESPACE, ENTER_SPECTATING_FUNCTION)

                    // Reduce kills by 1
                    scoreboard.players.remove(self(), CrossfireScoreboards.ROUND_KILLS, 1)

                    // Remove 1 from the kills of the player's team's visual score
                    for (teamName in References.TEAM_NAMES) {
                        execute {
                            ifCondition {
                                entity(self {
                                    team = teamName
                                })
                            }

                            run {
                                scoreboard.players.remove(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.TEAM_KILLS, 1)
                            }
                        }
                    }

                    // Add an action bar message
                    title(self(), TitleLocation.ACTIONBAR, textComponent("A point has been taken away because you fell in the water.", Color.RED))

                    // Play a sound effect
                    playSound("minecraft:entity.generic.splash", "player", self(), AT_POSITION, 2.0, 1.0)
                }
            }
        }
    }
}