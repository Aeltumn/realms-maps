package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.clearBossBarPlayers
import com.aeltumn.realms.common.load
import com.aeltumn.realms.common.setBossBarName
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.DisplaySlots
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.teams

/** Set up the basic map system with state and timer management. */
public object MapSystem : Configurable {

    override fun DataPack.configure() {
        // Set up script that reset maps
        for (map in References.MAPS) {
            load("reset_map_$map") {
                // Clear the visibility of both boss bars
                clearBossBarPlayers(CrossfireBossbars.getTimer(map), References.NAMESPACE)
                setBossBarName(CrossfireBossbars.getTimer(map), References.NAMESPACE, textComponent(""))
                clearBossBarPlayers(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE)
                setBossBarName(CrossfireBossbars.getPostGameTimer(map), References.NAMESPACE, textComponent(""))

                // Clear the kills values
                for (teamName in requireNotNull(References.TEAMS[map]).keys) {
                    execute {
                        run {
                            scoreboard.players.reset(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.TEAM_KILLS)
                        }
                    }
                }

                // Clear out all teams
                for (key in References.TEAMS[map]!!.keys) {
                    teams.empty(key)
                }

                // Reset scoreboard values for this map
                scoreboard {
                    player(literal(map)) {
                        set(CrossfireScoreboards.STARTED, 0)
                        set(CrossfireScoreboards.GAME_STATE, 0)
                        set(CrossfireScoreboards.JOINED, 0)
                        set(CrossfireScoreboards.START_TIMER, -1)
                        set(CrossfireScoreboards.GAME_TIMER, -1)
                        set(CrossfireScoreboards.POST_GAME_TIMER, -1)
                    }
                }

                // Hide the sidebar if no game is running
                execute {
                    // Test if any map is still running
                    for (mapName in References.MAPS) {
                        unlessCondition {
                            score(literal(mapName), CrossfireScoreboards.STARTED) equalTo 1
                        }
                    }

                    run {
                        // Clear the objective
                        addLine(
                            command(
                                "scoreboard",
                                literal("objectives"),
                                literal("setdisplay"),
                                DisplaySlots.sidebar
                            )
                        )
                    }
                }
            }
        }
    }
}