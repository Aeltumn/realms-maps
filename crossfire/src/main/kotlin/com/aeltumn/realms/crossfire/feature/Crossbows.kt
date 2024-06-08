package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.CONTAINER
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.components.types.itemName
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.functions.function

/** Sets up the crossbow mechanic. */
public object Crossbows {

    /** Function that cancels a crossbow reloading. */
    public const val CANCEL_RELOAD: String = "cancel_reload"

    /** Configures the crossbow mechanic. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            val emptyCrossbowItem = item("crossbow") {
                itemName("Empty Crossbow", color = Color.DARK_GRAY)
            }

            // A function which cancels the reload and resets the crossbow
            function(CANCEL_RELOAD) {
                scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)

                items.replace(self(), CONTAINER[1], emptyCrossbowItem, count = 1)
            }
        }
    }
}