package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.player
import io.github.ayfri.kore.commands.bossBars
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.functions.function

/** Set up the basic map system with state and timer management. */
public object MapSystem : Configurable {

    override fun DataPack.configure() {
        // Set up lobby teleportation scripts that reset maps
        for (map in References.MAPS) {
            function("lobby_teleport_$map") {
                // Clear the visibility of both boss bars
                bossBars.get(CrossfireBossbars.getTimer(map), References.NAMESPACE).setPlayers(player("-"))
                bossBars.get(CrossfireBossbars.getTimer(map), References.NAMESPACE).setName("")
                bossBars.get(CrossfireBossbars.getPostGame(map), References.NAMESPACE).setPlayers(player("-"))
                bossBars.get(CrossfireBossbars.getPostGame(map), References.NAMESPACE).setName("")

                // Clear out all teams
                for (key in References.TEAMS[map]!!.keys) {
                    teams.empty(key)
                }

                // Reset scoreboard values for this map
                scoreboard {
                    player(literal(map)) {
                        set(CrossfireScoreboards.STARTED, 0)
                        set(CrossfireScoreboards.JOINED, 0)
                        set(CrossfireScoreboards.START_TIMER, -1)
                        set(CrossfireScoreboards.GAME_TIMER, -1)
                        set(CrossfireScoreboards.POST_GAME_TIMER, -1)
                        set(CrossfireScoreboards.ROUND, 1)
                    }
                }
            }
        }
    }
}