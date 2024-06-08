package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.component.CrossfireTeams
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.enums.ExperienceType
import io.github.ayfri.kore.arguments.enums.Gamemode
import io.github.ayfri.kore.arguments.numbers.Xp
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.attributes
import io.github.ayfri.kore.commands.clear
import io.github.ayfri.kore.commands.effect
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamemode
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.spectate
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.commands.xp
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.generated.Attributes
import io.github.ayfri.kore.generated.Effects
import java.util.UUID

/** Sets up player management. */
public object ManagePlayers {

    /** The name of the reset player function. */
    public const val RESET_PLAYER_FUNCTION: String = "reset_player"

    /** The attribute used for removing gravity. */
    public val NO_GRAVITY_ATTRIBUTE: UUID = UUID.fromString("057b7e57-6d30-4c39-b65c-16efc5025383")

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
                    for ((index, map) in References.MAPS.withIndex()) {
                        remove("${CrossfireTags.JOINED}-$index")
                    }
                    remove(CrossfireTags.SHOOTING_RANGE)

                    // We always give people crossbows, a bit dangerous, but alright.
                    add(CrossfireTags.GIVE_CROSSBOW)
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
                }

                // Reset values
                scoreboard.players.set(self(), CrossfireScoreboards.INTRO, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.DEAD_TIMER, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.RESPAWN_SHIELD, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.WINS, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.ROUND_KILLS, 0)

                // Enable triggers
                scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_START_TRIGGER)
                scoreboard.players.enable(self(), CrossfireScoreboards.INTRO_SKIPPED_TRIGGER)

                // TODO Teleport player to their map (add 0 to map so it's at least 0)
                scoreboard.players.add(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)
            }
        }
    }
}