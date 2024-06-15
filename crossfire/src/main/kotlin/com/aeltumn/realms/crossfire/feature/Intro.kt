package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.executeIfEqualTo
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.events.HoverAction
import io.github.ayfri.kore.arguments.chatcomponents.events.showText
import io.github.ayfri.kore.arguments.chatcomponents.hoverEvent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.enums.Gamemode
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamemode
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.spectate
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.functions.Function

/**
 * Sets up the intro.
 * The intro is accessed by setting ones map to -1.
 */
public object Intro : Configurable {

    override fun DataPack.configure() {
        // Listen to anyone triggering an intro skip
        tick("intro_skip_trigger") {
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.INTRO_SKIPPED_TRIGGER) greaterThanOrEqualTo 1
                        }
                    }
                )

                run {
                    scoreboard.players.set(self(), CrossfireScoreboards.INTRO_SKIPPED_TRIGGER, 0)

                    // If the player is currently in the intro we take them out of it!
                    executeIfEqualTo(CrossfireScoreboards.TARGET_MAP_INDEX, -1) {
                        scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)
                    }
                    scoreboard.players.set(self(), CrossfireScoreboards.INTRO_COMPLETED, 1)

                    title(self(), TitleLocation.ACTIONBAR, textComponent("You've skipped the tutorial.", Color.YELLOW))
                }
            }
        }

        // Listen to anyone triggering an intro start
        tick("intro_start_trigger") {
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.INTRO_START_TRIGGER) greaterThanOrEqualTo 1
                        }
                    }
                )

                run {
                    scoreboard.players.set(self(), CrossfireScoreboards.INTRO_START_TRIGGER, 0)
                    scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, -1)
                }
            }
        }

        // Run the intro whenever someone is in it
        tick("run_intro") {
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo -1
                        }
                    }
                )

                run {
                    /** Runs a part of the intro at [amount] using [function]. */
                    fun runIfAt(amount: Int, function: Function.() -> Command) {
                        executeIfEqualTo(CrossfireScoreboards.INTRO, amount * 20, function = function)
                    }

                    // Increment their current intro value by one as long as they are in the intro
                    scoreboard.players.add(self(), CrossfireScoreboards.INTRO, 1)

                    // Move the player into spectator
                    gamemode(Gamemode.SPECTATOR, self())

                    // PHASE 1 - Lobby
                    runIfAt(1) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("Welcome to "))
                                plus(textComponent("Crossfire", Color.GOLD))
                                plus(textComponent("! A team vs team mini-game where you try to hit your friends with fireworks shot from a crossbow. You can join a team of your choosing by walking on one of the "))
                                plus(textComponent("colored areas", Color.YELLOW))
                                plus(textComponent("."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                    runIfAt(7) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent(""))
                                plus(textComponent("Crossfire", Color.GOLD))
                                plus(textComponent(" can be played on two maps: "))
                                plus(textComponent("Party", Color.AQUA) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("A map where four teams play together at once: "))
                                            plus(textComponent("Red", Color.RED))
                                            plus(textComponent(", "))
                                            plus(textComponent("Yellow", Color.YELLOW))
                                            plus(textComponent(", "))
                                            plus(textComponent("Green", Color.GREEN))
                                            plus(textComponent(" and "))
                                            plus(textComponent("Blue", Color.AQUA))
                                            plus(textComponent(". The map is more focussed towards finding out the position of your enemies than direct confrontation."))
                                        }
                                    }
                                })
                                plus(textComponent(" and "))
                                plus(textComponent("Duel", Color.GREEN) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("The duel map is played on by only two teams, "))
                                            plus(textComponent("Orange", Color.GOLD))
                                            plus(textComponent(" and "))
                                            plus(textComponent("Magenta", Color.LIGHT_PURPLE))
                                            plus(textComponent(". The map is focussed on trying to evade incoming attacks whilst trying to attack yourself. The map is very open so spotting the enemy won't be hard."))
                                        }
                                    }
                                })
                                plus(textComponent(". The maps have different amounts of participating teams and each offer a different experience. Both maps can be played simultaneously. You can switch between maps using the "))
                                plus(textComponent("arrow", Color.GOLD))
                                plus(textComponent(" item in your inventory."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }

                    // PHASE 2 - Shooting Range
                    runIfAt(19) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("During the game you'll receive your main weapon: "))
                                plus(textComponent("the crossbow", Color.DARK_PURPLE))
                                plus(textComponent(". It will automatically reload but only whilst you're holding it."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                    runIfAt(24) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("Whenever you use "))
                                plus(textComponent("the crossbow", Color.DARK_PURPLE))
                                plus(textComponent(" it will shoot a "))
                                plus(textComponent("fireworks rocket", Color.LIGHT_PURPLE))
                                plus(textComponent(". This rocket will explode as soon as it hits something. Anyone hit by a rocket will be 'sploded, shot into the skies above and respawn again after a few seconds. Players have "))
                                plus(textComponent("5 seconds of invulnerability", Color.YELLOW))
                                plus(textComponent(" after respawning."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }

                    // PHASE 3 - Game
                    runIfAt(32) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("During the game there will sometimes be some "))
                                plus(textComponent("loot crates", Color.GOLD))
                                plus(textComponent(" that will spawn in the skies. If they are hit with fireworks they will fall down and drop their contents. "))
                                plus(textComponent("These crates contain powerful power-ups that can change the tide of battle.", Color.RED))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                    runIfAt(37) {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("The team that gets the most points will win in the end."))
                                plus(textComponent(" You get one point for every kill,", Color.RED))
                                plus(textComponent(" but lose a point every time you fall into the water.", Color.AQUA))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }

                    // If the intro value has reached 40 we end the intro
                    executeIfEqualTo(CrossfireScoreboards.INTRO, 40 * 20) {
                        scoreboard.players.set(self(), CrossfireScoreboards.INTRO_COMPLETED, 1)
                        scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)

                        // Reset the player
                        function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
                    }
                }
            }

            // Set the current camera based on the current time
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.INTRO) matches (0 * 20)..<(18 * 20)
                        }
                    }
                )

                run {
                    spectate(
                        allEntities(true) {
                            tag = "camera0"
                        },
                        self()
                    )
                }
            }
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.INTRO) matches (18 * 20)..(31 * 20)
                        }
                    }
                )

                run {
                    spectate(
                        allEntities(true) {
                            tag = "camera1"
                        },
                        self()
                    )
                }
            }
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.INTRO) greaterThan (31 * 20)
                        }
                    }
                )

                run {
                    spectate(
                        allEntities(true) {
                            tag = "camera2"
                        },
                        self()
                    )
                }
            }
        }
    }
}