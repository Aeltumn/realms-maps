package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.enums.Gamemode
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamemode
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.functions.function

/** Sets up player management. */
public object ManagePlayers {

    /** The name of the reset player function. */
    public const val RESET_PLAYER_FUNCTION: String = "reset_player"

    /** Configures player management. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
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

            function(RESET_PLAYER_FUNCTION) {
                // Mark as initialized
                tag(self()) {
                    add(CrossfireTags.INITIALIZED)
                }

                // Reset game mode
                gamemode(Gamemode.ADVENTURE, self())

                // Reset values
                scoreboard.players.set(self(), CrossfireScoreboards.INTRO, 0)

                // Enable triggers
                scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_START_TRIGGER)
                scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_SKIPPED_TRIGGER)

                // TODO Teleport player to their map
            }
        }
    }
}