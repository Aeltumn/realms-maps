package com.aeltumn.realms.crossfire

import com.aeltumn.realms.common.BootstrapHelper
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.Setuppable
import com.aeltumn.realms.common.filterOutDefaults
import com.aeltumn.realms.common.load
import com.aeltumn.realms.crossfire.component.CrossfireBossbars
import com.aeltumn.realms.crossfire.component.CrossfirePredicates
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.component.CrossfireTeams
import com.aeltumn.realms.crossfire.component.CrossfireTimers
import com.aeltumn.realms.crossfire.feature.Crossbows
import com.aeltumn.realms.crossfire.feature.Flightpaths
import com.aeltumn.realms.crossfire.feature.GameLoop
import com.aeltumn.realms.crossfire.feature.Interactables
import com.aeltumn.realms.crossfire.feature.Intro
import com.aeltumn.realms.crossfire.feature.ManagePlayers
import com.aeltumn.realms.crossfire.feature.MapSwitching
import com.aeltumn.realms.crossfire.feature.MapSystem
import com.aeltumn.realms.crossfire.feature.ShootingRange
import com.aeltumn.realms.crossfire.feature.Spectating
import com.aeltumn.realms.crossfire.feature.TeamJoin
import com.aeltumn.realms.crossfire.feature.TouchWater
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.enums.Difficulty
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.commands.difficulty
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.gamerule
import io.github.ayfri.kore.commands.kill
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

        // Configure features
        Configurable.apply(
            this,
            CrossfirePredicates,
            CrossfireTags,
            Crossbows,
            Flightpaths,
            GameLoop,
            Interactables,
            Intro,
            ManagePlayers,
            MapSwitching,
            MapSystem,
            ShootingRange,
            Spectating,
            TeamJoin,
            TouchWater
        )

        // Set up initial functions
        load("setup") {
            // Set up components
            Setuppable.apply(
                this,
                CrossfireBossbars,
                CrossfireScoreboards,
                CrossfireTeams,
                CrossfireTimers,
            )

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
            gamerule(Gamerules.SEND_COMMAND_FEEDBACK, BootstrapHelper.DEVELOPMENT_MODE)

            // Teleport all players to their lobbies
            for (map in References.MAPS) {
                function(References.NAMESPACE, "lobby_teleport_$map")
            }
        }
    }
}