package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.clearBossBarPlayers
import com.aeltumn.realms.common.executeAt
import com.aeltumn.realms.common.executeIfEqualTo
import com.aeltumn.realms.common.setBossBarName
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
import io.github.ayfri.kore.arguments.types.literals.SelectorArgument
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.BlockArgument
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.bossBars
import io.github.ayfri.kore.commands.clone
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.fill
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.randomValue
import io.github.ayfri.kore.commands.schedules
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.commands.tp
import io.github.ayfri.kore.functions.Function
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.helpers.predicateRandomChance

/** Sets up the main game loop. */
public object GameLoop : Configurable {

    private const val POST_GAME_TIMER_SECONDS: Int = 26

    override fun DataPack.configure() {
        for ((mapIndex, map) in References.MAPS.withIndex()) {
            val startTimer = TimerIdentifier(map, "start")
            val gameTimer = TimerIdentifier(map, "game")
            val postGameTimer = TimerIdentifier(map, "post_game")

            // All selectors that are in this map
            val selector = mapMembersSelector(mapIndex)

            /** Stores the amount of available teams in [CrossfireScoreboards.TEAM_COUNT]. */
            fun Function.countTeams() {
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
            }

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
                countTeams()

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
                        tellraw(
                            selector,
                            ChatComponents().apply {
                                plus(textComponent("You need to have at least 2 teams with players in them."))
                            }
                        )
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT) equalTo 1
                    }
                    run {
                        tellraw(
                            selector,
                            ChatComponents().apply {
                                plus(textComponent("Not enough players have chosen a team yet!"))
                            }
                        )
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.PLAYER_COUNT) greaterThan 12
                    }
                    run {
                        tellraw(
                            selector,
                            ChatComponents().apply {
                                plus(textComponent("Only a maximum of 12 players can participate in a game."))
                            }
                        )
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
                            scoreboard.players.set(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.KILLS, 0)
                            scoreboard.players.reset(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.WINNER)
                        }

                        // We store whether a draw occurred as the winner state on the map literal
                        scoreboard.players.reset(literal(map), CrossfireScoreboards.WINNER)

                        // Set this game to started
                        scoreboard.players.set(literal(map), CrossfireScoreboards.STARTED, 1)
                        scoreboard.players.set(literal(map), CrossfireScoreboards.GAME_STATE, 1)

                        // Set the timings for all players
                        title(selector, 0.0, 20 * 6.0, 0.0)

                        // Start the pre-game timer
                        scoreboard.players.set(literal(map), CrossfireScoreboards.START_TIMER, 6)
                        function(References.NAMESPACE, startTimer.path)

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
                        // Reduce the timer by one and run it again after a second
                        scoreboard.players.remove(literal(map), CrossfireScoreboards.START_TIMER, 1)
                        schedules.replace(startTimer.id, 1.seconds)

                        // Show a countdown title
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
                // Reduce the game timer value
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) greaterThanOrEqualTo 1
                    }
                    run {
                        // Reduce the timer by one and run it again after a second
                        scoreboard.players.remove(literal(map), CrossfireScoreboards.GAME_TIMER, 1)
                        schedules.replace(gameTimer.id, 1.seconds)
                    }
                }

                // Update the boss bar's contents
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) greaterThanOrEqualTo 0
                    }
                    run {
                        execute {
                            storeResult {
                                bossBarValue("${References.NAMESPACE}:${CrossfireBossbars.getTimer(map)}")
                            }
                            run {
                                scoreboard.players.get(literal(map), CrossfireScoreboards.GAME_TIMER)
                            }
                        }
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) greaterThanOrEqualTo 2
                    }
                    run {
                        setBossBarName(CrossfireBossbars.getTimer(map), References.NAMESPACE, ChatComponents().apply {
                            plus(textComponent("Game ends in: "))
                            plus(scoreComponent(CrossfireScoreboards.GAME_TIMER, literal(map)) {
                                bold = true
                                color = Color.GOLD
                            })
                            plus(textComponent(" seconds."))
                        })
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) equalTo 1
                    }
                    run {
                        setBossBarName(CrossfireBossbars.getTimer(map), References.NAMESPACE, ChatComponents().apply {
                            plus(textComponent("Game ends in: "))
                            plus(scoreComponent(CrossfireScoreboards.GAME_TIMER, literal(map)) {
                                bold = true
                                color = Color.GOLD
                            })
                            plus(textComponent(" second."))
                        })
                    }
                }

                // Spawn random crates throughout the round
                for (i in 20..280 step 20) {
                    execute {
                        ifCondition(predicateRandomChance(0.8f))
                        ifCondition {
                            score(literal(map), CrossfireScoreboards.GAME_TIMER) equalTo i
                        }
                        run {
                            when (map) {
                                "party" -> {
                                    execute {
                                        storeResult {
                                            score(literal(map), CrossfireScoreboards.SELECTED_RANDOM)
                                        }
                                        run {
                                            randomValue(0..7)
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 0, literal(map)) {
                                        executeAt(vec3(529.worldPos, 80.worldPos, 411.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 1, literal(map)) {
                                        executeAt(vec3(539.worldPos, 80.worldPos, 421.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 2, literal(map)) {
                                        executeAt(vec3(529.worldPos, 80.worldPos, 431.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 3, literal(map)) {
                                        executeAt(vec3(519.worldPos, 80.worldPos, 421.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }

                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 4, literal(map)) {
                                        executeAt(vec3(537.worldPos, 80.worldPos, 413.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_GOLD}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 5, literal(map)) {
                                        executeAt(vec3(537.worldPos, 80.worldPos, 429.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_GOLD}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 6, literal(map)) {
                                        executeAt(vec3(521.worldPos, 80.worldPos, 429.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_GOLD}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 7, literal(map)) {
                                        executeAt(vec3(521.worldPos, 80.worldPos, 413.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_GOLD}-$map")
                                        }
                                    }
                                }

                                "duel" -> {
                                    execute {
                                        storeResult {
                                            score(literal(map), CrossfireScoreboards.SELECTED_RANDOM)
                                        }
                                        run {
                                            randomValue(0..2)
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 0, literal(map)) {
                                        executeAt(vec3(517.worldPos, 80.worldPos, 296.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 1, literal(map)) {
                                        executeAt(vec3(541.worldPos, 80.worldPos, 296.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_IRON}-$map")
                                        }
                                    }
                                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 2, literal(map)) {
                                        executeAt(vec3(529.worldPos, 80.worldPos, 296.worldPos)) {
                                            function(References.NAMESPACE, "${Crates.SPAWN_GOLD}-$map")
                                        }
                                    }
                                }

                                else -> throw IllegalArgumentException("Invalid map name $map")
                            }
                        }
                    }
                }

                // Handle the timer's state
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_TIMER) greaterThanOrEqualTo 1
                    }
                    run {
                        // Detect if the game is ending and set the time to 0
                        countTeams()
                        execute {
                            ifCondition {
                                score(literal(map), CrossfireScoreboards.TEAM_COUNT) lessThanOrEqualTo 1
                            }
                            run {
                                scoreboard.players.set(literal(map), CrossfireScoreboards.GAME_TIMER, 0)
                                tellraw(
                                    selector,
                                    ChatComponents().apply {
                                        plus(textComponent("Only one team is left, the game will end now."))
                                    }
                                )
                            }
                        }
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

            function(postGameTimer.path) {
                // Handle the timer's state
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) greaterThanOrEqualTo 1
                    }
                    run {
                        // Reduce the timer by one and run it again after a second
                        scoreboard.players.remove(literal(map), CrossfireScoreboards.POST_GAME_TIMER, 1)
                        schedules.replace(postGameTimer.id, 1.seconds)
                    }
                }

                // Update the boss bar's contents
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) greaterThanOrEqualTo 0
                    }
                    run {
                        execute {
                            storeResult {
                                bossBarValue("${References.NAMESPACE}:${CrossfireBossbars.getPostGameTimer(map)}")
                            }
                            run {
                                scoreboard.players.get(literal(map), CrossfireScoreboards.POST_GAME_TIMER)
                            }
                        }
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) greaterThanOrEqualTo 2
                    }
                    run {
                        setBossBarName(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE, ChatComponents().apply {
                            plus(textComponent("Back to lobby in: "))
                            plus(scoreComponent(CrossfireScoreboards.POST_GAME_TIMER, literal(map)) {
                                bold = true
                                color = Color.GOLD
                            })
                            plus(textComponent(" seconds."))
                        })
                    }
                }
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) equalTo 1
                    }
                    run {
                        setBossBarName(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE, ChatComponents().apply {
                            plus(textComponent("Back to lobby in: "))
                            plus(scoreComponent(CrossfireScoreboards.POST_GAME_TIMER, literal(map)) {
                                bold = true
                                color = Color.GOLD
                            })
                            plus(textComponent(" second."))
                        })
                    }
                }

                /*
                execute if score Red winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;11743532]}],Flight:2}}}}
                execute if score Yellow winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;14602026]}],Flight:2}}}}
                execute if score Green winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;4312372]}],Flight:2}}}}
                execute if score Blue winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;6719955]}],Flight:2}}}}
                execute if score Red winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;11743532]}],Flight:2}}}}
                execute if score Yellow winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;14602026]}],Flight:2}}}}
                execute if score Green winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;4312372]}],Flight:2}}}}
                execute if score Blue winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;6719955]}],Flight:2}}}}

                execute if score Orange winner matches 1 run summon firework_rocket 525.5 76 292.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;15435844]}],Flight:2}}}}
                execute if score Magenta winner matches 1 run summon firework_rocket 525.5 76 292.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;12801229]}],Flight:2}}}}
                execute if score Orange winner matches 1 run summon firework_rocket 533.5 76 300.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;15435844]}],Flight:2}}}}
                execute if score Magenta winner matches 1 run summon firework_rocket 533.5 76 300.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;12801229]}],Flight:2}}}}
                 */

                // Play a song during the first 5 seconds of the post game
                for ((index, winnerNote) in listOf(1.3, 1.1, 1.4, 1.6, 1.9).withIndex()) {
                    execute {
                        ifCondition {
                            score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) equalTo (POST_GAME_TIMER_SECONDS - index - 1)
                        }
                        asTarget(
                            allPlayers {
                                tag = CrossfireTags.WINNER
                                scores {
                                    score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
                                }
                            }
                        )
                        at(self())
                        run {
                            playSound(
                                SoundArgument("block.note_block.bit"),
                                PlaySoundMixer.PLAYER,
                                self(),
                                AT_POSITION,
                                100.0,
                                winnerNote
                            )
                        }
                    }
                }
                for ((index, loserNote) in listOf(1.0, 0.9, 0.7, 0.6, 0.3).withIndex()) {
                    execute {
                        ifCondition {
                            score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) equalTo (POST_GAME_TIMER_SECONDS - index - 1)
                        }
                        asTarget(
                            allPlayers {
                                tag = CrossfireTags.LOSER
                                scores {
                                    score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
                                }
                            }
                        )
                        at(self())
                        run {
                            playSound(
                                SoundArgument("block.note_block.bit"),
                                PlaySoundMixer.PLAYER,
                                self(),
                                AT_POSITION,
                                100.0,
                                loserNote
                            )
                        }
                    }
                }

                // If we're at zero we run the end script
                execute {
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.POST_GAME_TIMER) equalTo 0
                    }
                    run {
                        // Reset the map itself
                        when (map) {
                            "party" -> {
                                // Copy back the logo
                                clone(vec3(464, 95, 345), vec3(467, 75, 382), vec3(525, 89, 403))
                            }

                            "duel" -> {
                                // Copy back the logo
                                clone(vec3(464, 95, 345), vec3(467, 75, 382), vec3(525, 89, 278))
                            }

                            else -> throw IllegalArgumentException("Invalid map name $map")
                        }
                        function(References.NAMESPACE, "reset_map_$map")

                        // Reset all players in the map
                        execute {
                            asTarget(selector)
                            run {
                                function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
                            }
                        }
                    }
                }
            }

            // Start handling
            function("start_map_$map") {
                // Select all players in this area
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
                title(selector, 0.0, 20.0, 0.0)
                title(
                    selector,
                    TitleLocation.TITLE,
                    textComponent("GO", color = Color.GOLD) {
                        bold = true
                    }
                )

                // Update the game state
                scoreboard.players.set(literal(map), CrossfireScoreboards.GAME_STATE, 2)

                // Show the boss bar for all players in the map
                clearBossBarPlayers(CrossfireBossbars.getTimer(map), References.NAMESPACE)
                bossBars.get(CrossfireBossbars.getTimer(map), References.NAMESPACE).setPlayers(selector)

                // Start the game timer
                scoreboard.players.set(literal(map), CrossfireScoreboards.GAME_TIMER, 301)
                function(References.NAMESPACE, gameTimer.path)

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
                // Set the game state to post game
                scoreboard.players.set(literal(map), CrossfireScoreboards.GAME_STATE, 3)

                // Show the post game boss bar for all players in the map
                clearBossBarPlayers(CrossfireBossbars.getTimer(map), References.NAMESPACE)
                clearBossBarPlayers(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE)
                bossBars.get(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE).setPlayers(selector)

                // Remove any entities marked as cleanup on this map specifically
                kill(allEntities { tag = "cleanup-$map" })

                // Take away crossbow permissions so they stop reloading
                tag(selector) {
                    remove(CrossfireTags.RELOAD_CROSSBOW)
                }

                // Teleport all players to the middle of the map
                when (map) {
                    "party" -> {
                        tp(selector, vec3(529, 72, 421), rotation((-90.0).rot, 0.0.rot))
                    }

                    "duel" -> {
                        tp(selector, vec3(529, 71, 296), rotation((-90.0).rot, 0.0.rot))
                    }

                    else -> throw IllegalArgumentException("Invalid map name $map")
                }

                // Start the post game timer
                scoreboard.players.set(literal(map), CrossfireScoreboards.POST_GAME_TIMER, POST_GAME_TIMER_SECONDS)
                function(References.NAMESPACE, postGameTimer.path)
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
            scoreboard.players.set(self(), CrossfireScoreboards.DEAD_TIMER, 6 * 20)
            scoreboard.players.set(self(), CrossfireScoreboards.RESPAWN_SHIELD, 5 * 20)
        }
    }
}

/** Creates a selector for all players in [mapIndex]. */
public fun mapMembersSelector(mapIndex: Int): SelectorArgument =
    allPlayers {
        scores {
            score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo mapIndex
        }
    }