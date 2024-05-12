package com.aeltumn.realms.crossfire

import com.aeltumn.realms.common.BootstrapHelper
import com.aeltumn.realms.common.filterOutDefaults
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.enums.Difficulty
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.commands.bossBars
import io.github.ayfri.kore.commands.difficulty
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamerule
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.functions.load
import io.github.ayfri.kore.generated.Gamerules
import io.github.ayfri.kore.pack.pack
import java.nio.file.Paths
import io.github.ayfri.kore.arguments.types.literals.player as playerTarget

/**
 * Bootstraps the datapack creation.
 * The target directory can be passed as an argument to generate the map directly in the Minecraft
 * saves directory for easier testing/iteration.
 */
public fun main(args: Array<String>) {
    val outputFolder = if (args.isEmpty()) {
        Paths.get("out/crossfire/")
    } else {
        Paths.get("${args[0]}/crossfire")
    }
    val resourcePackSource = Paths.get("resource-packs/crossfire/").toFile()
    val worldSource = Paths.get("maps/crossfire/")
    val release = false // TODO <- edit this!

    BootstrapHelper(
        outputFolder,
        resourcePackSource,
        worldSource,
        "crossfire"
    ).execute {
        filterOutDefaults()
        pack {
            description = textComponent("The main datapack that makes our maps work!")
        }

        // Configure basic tags
        CrossfireTags.configure(this)

        // Set up initial functions
        load("setup") {
            // Create scoreboards
            CrossfireScoreboards.setup(this)

            // Create timers
            CrossfireTimers.setup(this)

            // Create teams
            CrossfireTeams.setup(this)

            // Create boss bars
            CrossfireBossbars.setup(this)

            // Remove any entities marked as cleanup
            kill(
                allEntities {
                    tag = "cleanup"
                }
            )

            // Set up basic game state
            difficulty(Difficulty.PEACEFUL)
            gamerule(Gamerules.ANNOUNCE_ADVANCEMENTS, false)
            gamerule(Gamerules.DISABLE_RAIDS, true)
            gamerule(Gamerules.DO_INSOMNIA, false)
            gamerule(Gamerules.DO_PATROL_SPAWNING, false)
            gamerule(Gamerules.DO_TRADER_SPAWNING, false)
            gamerule(Gamerules.DO_WEATHER_CYCLE, false)
            gamerule(Gamerules.DROWNING_DAMAGE, false)
            gamerule(Gamerules.FIRE_DAMAGE, false)
            gamerule(Gamerules.FALL_DAMAGE, false)
            gamerule(Gamerules.MOB_GRIEFING, false)
            gamerule(Gamerules.DO_MOB_SPAWNING, false)
            gamerule(Gamerules.NATURAL_REGENERATION, false)
            gamerule(Gamerules.SEND_COMMAND_FEEDBACK, !release)

            // Set the value of round to 1 for both maps
            for (map in References.MAPS) {
                scoreboard {
                    player(playerTarget(map)) {
                        set(CrossfireScoreboards.ROUND, 1)
                    }
                }
            }

            // Teleport all players to their lobbies
            for (map in References.MAPS) {
                function(References.NAMESPACE, "lobby_teleport_$map")
            }
        }

        load("respawn") {
        }

        load("introduction") {
        }

        load("team_deny_info") {
        }

        for (map in References.MAPS) {
            function("lobby_teleport_$map", References.NAMESPACE) {
                // Clear the visibility of both boss bars
                bossBars.get(CrossfireBossbars.getTimer(map), References.NAMESPACE).setPlayers(playerTarget("doesn't exist"))
                bossBars.get(CrossfireBossbars.getPostGame(map), References.NAMESPACE).setPlayers(playerTarget("doesn't exist"))

                // Clear out all teams
                for (key in References.TEAMS[map]!!.keys) {
                    teams.empty(key)
                }

                // Reset scoreboard values for this map
                scoreboard {
                    player(playerTarget(map)) {
                        set(CrossfireScoreboards.STARTED, 0)
                        set(CrossfireScoreboards.JOINED, 0)
                        set(CrossfireScoreboards.GAME_TIMER, -1)
                        set(CrossfireScoreboards.POST_GAME_TIMER, -1)
                        set(CrossfireScoreboards.START_TIMER, -1)
                        set(CrossfireScoreboards.ROUND, 1)
                    }
                }
            }
        }
    }
}

/*
Ticking functions:
"values": [
		"crossfire:tick/shoot_bow",
        "crossfire:tick/tick_rockets",
		"crossfire:tick/team_join",
		"crossfire:tick/shooting_range_join",
		"crossfire:tick/crossbowreload",
		"crossfire:tick/detect_round",
        "crossfire:tick/check_gamemode",
		"crossfire:tick/check_water",
		"crossfire:tick/flightpath",
        "crossfire:tick/crate_tick",
		"crossfire:tick/collect_powerup",
		"crossfire:tick/use_powerup",
		"crossfire:tick/increase_switch_timer",
		"crossfire:tick/intro_completion"
	]
 */