package com.aeltumn.realms.crossfire

import com.aeltumn.realms.common.BootstrapHelper
import com.aeltumn.realms.common.collect
import com.aeltumn.realms.common.filterOutDefaults
import io.github.ayfri.kore.arguments.chatcomponents.text
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.functions.load
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

    BootstrapHelper(
        outputFolder,
        resourcePackSource,
        worldSource,
        "crossfire"
    ).execute {
        filterOutDefaults()
        pack {
            description = text("The main datapack that makes our maps work!").collect()
        }

        // Configure basic tags
        CrossfireTags.configure(this)

        // Set up initial functions
        load("setup") {
            // Remove any entities marked as cleanup
            kill(
                allEntities {
                    tag = "cleanup"
                }
            )
        }

        load("respawn") {
        }

        load("introduction") {
        }

        load("team_deny_info") {
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