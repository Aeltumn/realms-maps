package com.aeltumn.realms.crossfire

import com.aeltumn.realms.common.BootstrapHelper
import com.aeltumn.realms.common.filterOutDefaults
import com.aeltumn.realms.common.load
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfirePredicates
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.component.CrossfireTeams
import com.aeltumn.realms.crossfire.component.CrossfireTimers
import com.aeltumn.realms.crossfire.feature.Intro
import com.aeltumn.realms.crossfire.feature.ManagePlayers
import com.aeltumn.realms.crossfire.feature.MapSwitching
import com.aeltumn.realms.crossfire.feature.MapSystem
import com.aeltumn.realms.crossfire.feature.TeamJoin
import com.aeltumn.realms.crossfire.feature.TouchWater
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.enums.Difficulty
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.commands.difficulty
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamerule
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.generated.Gamerules
import io.github.ayfri.kore.pack.pack
import java.nio.file.Paths

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
        References.NAMESPACE,
    ).execute {
        filterOutDefaults()
        pack {
            description = textComponent("The main datapack that makes our maps work!")
        }

        // Configure basic components
        CrossfirePredicates.configure(this)
        CrossfireTags.configure(this)

        // Configure features
        Intro.configure(this)
        MapSwitching.configure(this)
        TouchWater.configure(this)
        MapSystem.configure(this)
        TeamJoin.configure(this)
        ManagePlayers.configure(this)

        // Set up initial functions
        load("setup") {
            // Set up components
            CrossfireScoreboards.setup(this)
            CrossfireTimers.setup(this)
            CrossfireTeams.setup(this)
            CrossfireBossbars.setup(this)

            // Remove any entities marked as cleanup
            kill(allEntities { tag = "cleanup" })

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
                    player(literal(map)) {
                        set(CrossfireScoreboards.ROUND, 1)
                    }
                }
            }

            // Teleport all players to their lobbies
            for (map in References.MAPS) {
                function(References.NAMESPACE, "lobby_teleport_$map")
            }
        }

        // TODO -- Cleanup

        /*load("respawn") {
        }

        load("introduction") {
        }

        load("team_deny_info") {
        }*/

        // TODO Add reset player to auto trigger whenever the current map index of a player has changed
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
		"crossfire:tick/use_powerup"
	]
 */