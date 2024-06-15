package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.clearBossBarPlayers
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.component.CrossfireTeams
import com.aeltumn.realms.crossfire.feature.Spectating.ENTER_SPECTATING_FUNCTION
import com.aeltumn.realms.crossfire.feature.TeamJoin.GIVE_ARMOR
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.scoreComponent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.enums.ExperienceType
import io.github.ayfri.kore.arguments.enums.Gamemode
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.Xp
import io.github.ayfri.kore.arguments.numbers.rot
import io.github.ayfri.kore.arguments.numbers.ticks
import io.github.ayfri.kore.arguments.numbers.worldPos
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.attributes
import io.github.ayfri.kore.commands.bossBars
import io.github.ayfri.kore.commands.clear
import io.github.ayfri.kore.commands.effect
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamemode
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.spectate
import io.github.ayfri.kore.commands.summon
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.commands.tp
import io.github.ayfri.kore.commands.xp
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.generated.Attributes
import io.github.ayfri.kore.generated.Effects
import io.github.ayfri.kore.generated.EntityTypes
import net.benwoodworth.knbt.NbtByte
import net.benwoodworth.knbt.NbtCompound
import net.benwoodworth.knbt.NbtInt
import net.benwoodworth.knbt.NbtIntArray
import net.benwoodworth.knbt.NbtList
import net.benwoodworth.knbt.NbtString
import java.util.UUID

/** Sets up player management. */
public object ManagePlayers : Configurable {

    /** The name of the reset player function. */
    public const val RESET_PLAYER_FUNCTION: String = "reset_player"

    /** The attribute used for removing gravity. */
    public val NO_GRAVITY_ATTRIBUTE: UUID = UUID.fromString("057b7e57-6d30-4c39-b65c-16efc5025383")

    override fun DataPack.configure() {
        tick("init_new_player") {
            execute {
                asTarget(
                    allPlayers {
                        tag = "!${CrossfireTags.INITIALIZED}"
                    }
                )

                run {
                    function(References.NAMESPACE, RESET_PLAYER_FUNCTION)
                }
            }
        }

        tick("tick_respawn") {
            // Tick down the dead timer
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.DIED

                        scores {
                            score(CrossfireScoreboards.DEAD_TIMER) greaterThanOrEqualTo 1
                        }
                    }
                )
                run {
                    scoreboard.players.remove(self(), CrossfireScoreboards.DEAD_TIMER, 1)
                }
            }

            // Tick down the respawn shield
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.RESPAWN_SHIELD) greaterThanOrEqualTo 1
                        }
                    }
                )
                run {
                    scoreboard.players.remove(self(), CrossfireScoreboards.RESPAWN_SHIELD, 1)
                }
            }

            // Add visuals to the last four seconds of the dead timer
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.DIED
                        scores {
                            score(CrossfireScoreboards.DEAD_TIMER) lessThanOrEqualTo (4 * 20)
                        }
                    }
                )
                run {
                    title(self(), 0.ticks, 24.ticks, 0.ticks)
                    title(self(), TitleLocation.TITLE, textComponent(""))
                }
            }
            for (i in 1..4) {
                execute {
                    asTarget(
                        allPlayers {
                            tag = CrossfireTags.DIED
                            scores {
                                score(CrossfireScoreboards.DEAD_TIMER) equalTo (20 * i)
                            }
                        }
                    )
                    run {
                        title(
                            self(),
                            TitleLocation.SUBTITLE,
                            ChatComponents().apply {
                                plus(textComponent("Respawning in: "))
                                plus(scoreComponent(CrossfireScoreboards.DEAD_TIMER, self()) {
                                    bold = true
                                    color = Color.GOLD
                                })
                            }
                        )
                    }
                }
            }

            // Make dead players spectator when 4 seconds remain on death timer (if not already spectating)
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.DIED
                        tag = !CrossfireTags.SPECTATING

                        scores {
                            score(CrossfireScoreboards.DEAD_TIMER) equalTo (4 * 20)
                        }
                    }
                )

                run {
                    // Add a firework based on the color of the team
                    for (teamName in References.TEAM_NAMES) {
                        execute {
                            ifCondition {
                                entity(self {
                                    team = teamName
                                })
                            }
                            at(self())
                            run {
                                summonFirework(teamName, "large_ball")
                            }
                        }
                    }

                    // Play a sound and make them a spectator
                    playSound(SoundArgument("item.trident.return"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 100.0, 0.0)
                    function(References.NAMESPACE, ENTER_SPECTATING_FUNCTION)
                }
            }

            // Respawn dead players when the timer reaches zero
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.DIED

                        scores {
                            score(CrossfireScoreboards.DEAD_TIMER) equalTo 0
                        }
                    }
                )
                run {
                    // Remove spectating related tags
                    tag(self()) {
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            remove("${CrossfireTags.SPECTATE_PLAYER}-$playerIndex")
                        }

                        remove(CrossfireTags.SPECTATING)
                        remove(CrossfireTags.DIED_IN_WATER)
                        remove(CrossfireTags.DIED)
                    }

                    // Reset the player's state (only the ones given by spectating)
                    attributes {
                        get(self(), Attributes.GENERIC_GRAVITY) {
                            modifiers {
                                remove(NO_GRAVITY_ATTRIBUTE)
                            }
                        }
                    }
                    effect(self()) {
                        clear(Effects.INVISIBILITY)
                    }
                    gamemode(Gamemode.ADVENTURE)

                    // Clear the title
                    title(self(), TitleLocation.TITLE, textComponent(""))
                    title(self(), TitleLocation.SUBTITLE, textComponent(""))

                    // Remove them from any spectator target
                    execute {
                        asTarget(self())
                        run {
                            spectate()
                        }
                    }

                    // Give them back armor
                    function(References.NAMESPACE, GIVE_ARMOR)

                    // Play sound for all other players in the map indicating the respawn
                    for ((index, map) in References.MAPS.withIndex()) {
                        execute {
                            ifCondition {
                                entity(self {
                                    tag = "${CrossfireTags.SELECTED}-$map"
                                })
                            }
                            asTarget(mapMembersSelector(index))
                            at(self())
                            run {
                                playSound(SoundArgument("item.armor.equip_turtle"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 0.4, 1.0)
                            }
                        }
                    }

                    // Initialize the player again
                    function(References.NAMESPACE, "init_player")
                }
            }
        }

        function(RESET_PLAYER_FUNCTION) {
            // Mark as initialized
            tag(self()) {
                // Give them the initialized tag if not already present
                add(CrossfireTags.INITIALIZED)

                // Remove spectator system tags
                for (playerIndex in 0 until References.PLAYER_COUNT) {
                    remove("${CrossfireTags.PLAYER}-$playerIndex")
                    remove("${CrossfireTags.SPECTATE_PLAYER}-$playerIndex")
                }
                remove(CrossfireTags.SPECTATING)
                remove(CrossfireTags.DIED_IN_WATER)
                remove(CrossfireTags.DIED)
                remove(CrossfireTags.RELOAD_CROSSBOW)

                remove(CrossfireTags.JOINED)
                remove(CrossfireTags.SELECTED)
                for (map in References.MAPS) {
                    remove("${CrossfireTags.JOINED}-$map")
                    remove("${CrossfireTags.SELECTED}-$map")
                }
                remove(CrossfireTags.SHOOTING_RANGE)

                // We always give people crossbows, a bit dangerous, but alright.
                add(CrossfireTags.GIVE_CROSSBOW)

                // Reset winning state
                remove(CrossfireTags.WINNER)
                remove(CrossfireTags.LOSER)
            }

            // Remove them from any spectator target
            execute {
                asTarget(self())
                run {
                    spectate()
                }
            }

            // Reset game mode and state
            gamemode(Gamemode.ADVENTURE, self())
            effect(self()) {
                clear()
            }
            xp(self()) {
                set(Xp(0, ExperienceType.LEVELS))
                set(Xp(0, ExperienceType.POINTS))
            }

            // Remove the no gravity attribute
            attributes {
                get(self(), Attributes.GENERIC_GRAVITY) {
                    modifiers {
                        remove(NO_GRAVITY_ATTRIBUTE)
                    }
                }
            }

            // Add to the lobby team
            teams {
                join(CrossfireTeams.LOBBY_TEAM, self())
            }

            // Just clear the whole inventory
            clear(self())

            // Give QOL effects
            effect(self()) {
                clear()
                give(Effects.INSTANT_HEALTH, 1, 20, true)
                giveInfinite(Effects.JUMP_BOOST, 1, true)
                giveInfinite(Effects.SPEED, 0, true)
                giveInfinite(Effects.WEAKNESS, 255, true)
                giveInfinite(Effects.RESISTANCE, 255, true)
                giveInfinite(Effects.SATURATION, 255, true)
            }

            // Reset values
            scoreboard.players.set(self(), CrossfireScoreboards.INTRO, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.DEAD_TIMER, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.RESPAWN_SHIELD, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.ROUND_KILLS, 0)

            // Enable triggers
            scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_START_TRIGGER)
            scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_SKIPPED_TRIGGER)

            // Teleport player to their map (add 0 to map so it's at least 0)
            scoreboard.players.add(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)
            execute {
                ifCondition { score(self(), CrossfireScoreboards.TARGET_MAP_INDEX) lessThanOrEqualTo 0 }
                run {
                    tp(self(), vec3(574.5.worldPos, 85.0.worldPos, 421.5.worldPos), rotation(90.0.rot, 0.0.rot))
                }
            }
            execute {
                ifCondition { score(self(), CrossfireScoreboards.TARGET_MAP_INDEX) greaterThanOrEqualTo 1 }
                run {
                    tp(self(), vec3(574.5.worldPos, 85.0.worldPos, 296.5.worldPos), rotation(90.0.rot, 0.0.rot))
                }
            }

            // Update the boss bar membership of each map
            for ((mapIndex, map) in References.MAPS.withIndex()) {
                clearBossBarPlayers(CrossfireBossbars.getTimer(map), References.NAMESPACE)
                clearBossBarPlayers(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE)

                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_STATE) equalTo 2
                    }
                    run {
                        bossBars.get(CrossfireBossbars.getTimer(map), References.NAMESPACE).setPlayers(mapMembersSelector(mapIndex))
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_STATE) equalTo 3
                    }
                    run {
                        bossBars.get(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE).setPlayers(mapMembersSelector(mapIndex))
                    }
                }
            }
        }
    }
}