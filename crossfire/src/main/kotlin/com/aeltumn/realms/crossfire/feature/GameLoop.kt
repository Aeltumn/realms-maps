package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.TimerIdentifier
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.scoreComponent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.ranges.rangeOrInt
import io.github.ayfri.kore.arguments.numbers.rot
import io.github.ayfri.kore.arguments.numbers.seconds
import io.github.ayfri.kore.arguments.numbers.worldPos
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.player
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.BlockArgument
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.bossBar
import io.github.ayfri.kore.commands.clone
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.fill
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.schedules
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.commands.tp
import io.github.ayfri.kore.functions.function

/** Sets up the main game loop. */
public object GameLoop : Configurable {

    override fun DataPack.configure() {
        for ((mapIndex, map) in References.MAPS.withIndex()) {
            val startTimer = TimerIdentifier(map, "start")
            val gameTimer = TimerIdentifier(map, "game")
            val postGameTimer = TimerIdentifier(map, "post_game")

            // Start function triggered by button in map
            function("start-$map") {
                // Determine the amount of players that joined
                scoreboard.players.set(literal(map), CrossfireScoreboards.PLAYER_COUNT, 0)
                execute {
                    asTarget(allPlayers {
                        tag = "${CrossfireTags.JOINED}-$map"
                    })
                    run {
                        scoreboard.players.add(literal(map), CrossfireScoreboards.PLAYER_COUNT, 1)
                    }
                }

                // Determine the amount of teams that exist
                scoreboard.players.set(literal(map), CrossfireScoreboards.TEAM_COUNT, 0)
                for (teamName in References.getTeamNames(map)) {
                    execute {
                        ifCondition {
                            entity(allPlayers {
                                team = teamName
                            })
                        }
                        run {
                            scoreboard.players.add(literal(map), CrossfireScoreboards.TEAM_COUNT, 1)
                        }
                    }
                }

                // If there only exists 0 or 1 teams set player count to 0
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.TEAM_COUNT) lessThanOrEqualTo 1
                    }
                    run {
                        scoreboard.players.set(literal(map), CrossfireScoreboards.PLAYER_COUNT, 0)
                    }
                }

                // Throw an error if we don't have enough players
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT) lessThanOrEqualTo 0
                    }
                    run {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("You need to have at least 2 teams with players in them."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT) equalTo 1
                    }
                    run {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("Not enough players have chosen a team yet!"))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT) greaterThan 12
                    }
                    run {
                        tellraw(self(), textComponent(""))
                        tellraw(
                            self(),
                            ChatComponents().apply {
                                plus(textComponent("Only a maximum of 12 players can participate in a game."))
                            }
                        )
                        tellraw(self(), textComponent(""))
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT, rangeOrInt(2..12))
                    }
                    run {
                        // Now we can start the game! Select all players that will be playing and assign them individual tags.
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            // Select the player to have this index
                            execute {
                                asTarget(allPlayers(true) {
                                    // Find someone who joined this map but was not yet selected
                                    tag = "${CrossfireTags.JOINED}-$map"
                                    tag = !CrossfireTags.SELECTED
                                })
                                run {
                                    // Give them tags
                                    tag(self()) {
                                        add("${CrossfireTags.PLAYER}-$playerIndex")
                                        add(CrossfireTags.SELECTED)
                                        add("${CrossfireTags.SELECTED}-$map")
                                    }

                                    // Initialize this player
                                    function(References.NAMESPACE, "init_player")
                                }
                            }
                        }

                        // Reset kills and winners for each team in use
                        for (teamName in References.getTeamNames(map)) {
                            scoreboard.players.remove(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.KILLS, 1)
                            scoreboard.players.reset(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.WINNER)
                        }

                        // We store whether a draw occurred as the winner state on the map literal
                        scoreboard.players.reset(literal(map), CrossfireScoreboards.WINNER)

                        // Set this game to started
                        scoreboard.players.set(literal(map), CrossfireScoreboards.STARTED, 1)

                        // Start the pre-game timer
                        scoreboard.players.set(literal(map), CrossfireScoreboards.START_TIMER, 5)
                        schedules.replace(startTimer.path, 1.seconds)

                        when (map) {
                            "party" -> {
                                // Create the cages per map
                                clone(vec3(438, 76, 383), vec3(444, 86, 386), vec3(526, 70, 440))
                                clone(vec3(438, 76, 388), vec3(444, 86, 391), vec3(526, 70, 399))
                                clone(vec3(444, 76, 393), vec3(441, 86, 399), vec3(548, 70, 418))
                                clone(vec3(441, 76, 407), vec3(444, 86, 401), vec3(507, 70, 418))

                                // Remove post-game barriers
                                fill(vec3(509, 70, 401), vec3(549, 70, 441), BlockArgument("air", "minecraft"), BlockArgument("barrier", "minecraft"))

                                // Remove the logos
                                fill(vec3(525, 109, 403), vec3(528, 89, 440), BlockArgument("air", "minecraft"))
                            }

                            "duel" -> {
                                // Create the cages per map
                                clone(vec3(438, 77, 364), vec3(432, 87, 361), vec3(526, 70, 274))
                                clone(vec3(438, 77, 369), vec3(432, 87, 366), vec3(526, 70, 315))

                                // Remove post-game barriers
                                fill(vec3(509, 70, 276), vec3(549, 70, 316), BlockArgument("air", "minecraft"), BlockArgument("barrier", "minecraft"))

                                // Remove the logos
                                fill(vec3(528, 89, 315), vec3(525, 109, 278), BlockArgument("air", "minecraft"))
                            }

                            else -> throw IllegalArgumentException("Invalid map name $map")
                        }
                    }
                }
            }

            // Runs the various timers
            function(startTimer.path) {
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.START_TIMER) greaterThanOrEqualTo 1
                    }
                    run {
                        // Show a countdown title
                        val selector = allPlayers {
                            scores {
                                score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
                            }
                        }
                        title(
                            selector,
                            TitleLocation.SUBTITLE,
                            textComponent("")
                        )
                        title(
                            selector,
                            TitleLocation.TITLE,
                            scoreComponent(
                                CrossfireScoreboards.START_TIMER,
                                literal(map),
                            ) {
                                bold = true
                                color = Color.GOLD
                            }
                        )

                        // Play a noise alongside the countdown
                        playSound(SoundArgument("entity.experience_orb.pickup", "minecraft"), PlaySoundMixer.PLAYER, selector, AT_POSITION, 0.2, 0.0)

                        // Reduce the timer by one and run it again after a second
                        scoreboard.players.remove(literal(map), CrossfireScoreboards.START_TIMER, 1)
                        schedules.replace(startTimer.path, 1.seconds)
                    }
                }

                // If we're at zero we run the start script
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.START_TIMER) equalTo 0
                    }
                    run {
                        function(References.NAMESPACE, "start_map_$map")
                    }
                }
            }
            function(gameTimer.path) {
                // Update the boss bar's contents


                // Handle the timer's state
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) greaterThanOrEqualTo 1
                    }
                    run {
                        // Show a countdown title
                        val selector = allPlayers {
                            scores {
                                score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
                            }
                        }

                        // Reduce the timer by one and run it again after a second
                        scoreboard.players.remove(literal(map), CrossfireScoreboards.GAME_TIMER, 1)
                        schedules.replace(gameTimer.path, 1.seconds)
                    }
                }

                // If we're at zero we run the end script
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) equalTo 0
                    }
                    run {
                        function(References.NAMESPACE, "end_map_$map")
                    }
                }
            }

            // Start handling
            function("start_map_$map") {
                // Select all players in this area
                val selector = allPlayers {
                    scores {
                        score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
                    }
                }
                execute {
                    asTarget(allPlayers {
                        // Only give crossbow permissions to those playing!
                        tag = "${CrossfireTags.SELECTED}-$map"
                    })
                    run {
                        // Give them tags to start reloading their crossbow
                        tag(self()) {
                            add(CrossfireTags.RELOAD_CROSSBOW)
                        }
                    }
                }

                // Play the starting effects
                playSound(SoundArgument("event.raid.horn", "minecraft"), PlaySoundMixer.PLAYER, selector, AT_POSITION, 100.0, 1.0)
                playSound(SoundArgument("entity.experience_orb.pickup", "minecraft"), PlaySoundMixer.PLAYER, selector, AT_POSITION, 0.2, 1.0)
                title(
                    selector,
                    TitleLocation.SUBTITLE,
                    textComponent("")
                )
                title(
                    selector,
                    TitleLocation.TITLE,
                    textComponent("GO", color = Color.GOLD) {
                        bold = true
                    }
                )

                // Show the boss bar for all players in the map
                bossBar(CrossfireBossbars.getTimer(map), References.NAMESPACE) {
                    setPlayers(player("-"))
                    setPlayers(selector)
                }

                // Start the game timer
                scoreboard.players.remove(literal(map), CrossfireScoreboards.GAME_TIMER, 300)
                schedules.replace(gameTimer.path, 1.seconds)

                when (map) {
                    "party" -> {
                        // Open up the cages
                        clone(vec3(446, 76, 383), vec3(452, 86, 386), vec3(526, 70, 440))
                        clone(vec3(446, 76, 388), vec3(452, 86, 391), vec3(526, 70, 399))
                        clone(vec3(452, 76, 393), vec3(449, 86, 399), vec3(548, 70, 418))
                        clone(vec3(449, 76, 407), vec3(452, 86, 401), vec3(507, 70, 418))
                    }

                    "duel" -> {
                        // Open up the cages
                        clone(vec3(446, 77, 364), vec3(440, 87, 361), vec3(526, 70, 274))
                        clone(vec3(446, 77, 369), vec3(440, 87, 366), vec3(526, 70, 315))
                    }

                    else -> throw IllegalArgumentException("Invalid map name $map")
                }
            }

            // End handling
            function("end_map_$map") {

            }
        }

        // Use a generalized initialization function
        function("init_player") {
            // Teleport them to their spawn
            execute {
                asTarget(self { team = "red" })
                run {
                    tp(self(), vec3(529.5.worldPos, 71.0.worldPos, 442.0.worldPos), rotation(180.0.rot, 0.0.rot))
                }
            }
            execute {
                asTarget(self { team = "yellow" })
                run {
                    tp(self(), vec3(509.0.worldPos, 71.0.worldPos, 421.5.worldPos), rotation((-90.0).rot, 0.0.rot))
                }
            }
            execute {
                asTarget(self { team = "lime" })
                run {
                    tp(self(), vec3(529.5.worldPos, 71.0.worldPos, 401.0.worldPos), rotation(0.0.rot, 0.0.rot))
                }
            }
            execute {
                asTarget(self { team = "light_blue" })
                run {
                    tp(self(), vec3(550.0.worldPos, 71.0.worldPos, 421.5.worldPos), rotation(90.0.rot, 0.0.rot))
                }
            }
            execute {
                asTarget(self { team = "orange" })
                run {
                    tp(self(), vec3(529.5.worldPos, 71.0.worldPos, 317.0.worldPos), rotation(180.0.rot, 0.0.rot))
                }
            }
            execute {
                asTarget(self { team = "magenta" })
                run {
                    tp(self(), vec3(529.5.worldPos, 71.0.worldPos, 276.0.worldPos), rotation(0.0.rot, 0.0.rot))
                }
            }

            // Prevent crossbow reloading
            tag(self()) {
                remove(CrossfireTags.RELOAD_CROSSBOW)
                remove(CrossfireTags.SHOOTING_RANGE)
                remove(CrossfireTags.HAS_CROSSBOW_LOADED)
                remove(CrossfireTags.HAS_MULTISHOT_LOADED)
            }

            // Set up the base timers
            scoreboard.players.set(self(), CrossfireScoreboards.DEAD_TIMER, 6)
            scoreboard.players.set(self(), CrossfireScoreboards.RESPAWN_SHIELD, 5)
        }
    }
}