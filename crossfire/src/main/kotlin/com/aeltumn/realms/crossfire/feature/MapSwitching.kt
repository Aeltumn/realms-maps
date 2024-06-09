package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.executeIfEqualTo
import com.aeltumn.realms.common.executeIfGreaterThanOrEqualTo
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.functions.function

/** Sets up map switching. */
public object MapSwitching : Configurable {

    override fun DataPack.configure() {
        // Implement a function to switch the map
        function("change_map") {
            executeIfGreaterThanOrEqualTo(CrossfireScoreboards.MAP_SWITCH_COOLDOWN, 50) {
                // Increment the map of this player by 1
                scoreboard.players.add(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 1)

                // Jump back to 0 if they went over the highest map's index
                executeIfEqualTo(CrossfireScoreboards.TARGET_MAP_INDEX, References.MAPS.size) {
                    scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)
                }

                // Restart the cooldown and leave the intro
                scoreboard.players.set(self(), CrossfireScoreboards.INTRO, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.MAP_SWITCH_COOLDOWN, 0)

                // Reset the player
                function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
            }
        }

        // Increment the switch timer for any players that have it below 50 until it equals 50
        tick("increment_switch_timer") {
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.MAP_SWITCH_COOLDOWN, 0..49)
                        }
                    }
                )
                run {
                    scoreboard.players.add(self(), CrossfireScoreboards.MAP_SWITCH_COOLDOWN, 1)
                }
            }
        }
    }
}