package com.aeltumn.realms.crossfire.component

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.features.tags.tag

/** Defines basic tags for crossfire. */
public object CrossfireTags {

    // -- Tags added to entities

    /** For players that have joined a game. */
    public const val JOINED: String = "joined"

    /** For players that died from touching water. */
    public const val DIED_IN_WATER: String = "died_in_water"

    /** For players that recently died. */
    public const val DIED: String = "died"

    /** For players that should be in the spectating sequence. */
    public const val SPECTATING: String = "spectating"

    /** For admin players that should be skipped when applying effects. */
    public const val ADMIN: String = "admin"

    // -- Tags that define items

    /** Contains just the crossbow. */
    public const val CROSSBOW: String = "crossbow"

    /** All items that are illegal for non-admins to have. */
    public const val ILLEGAL_ITEMS: String = "illegal_items"

    /** Configures the tags. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            tag(CROSSBOW, "items") {
                add("minecraft:crossbow")
            }

            tag(ILLEGAL_ITEMS, "items") {
                add("minecraft:arrow")
                add("minecraft:glass_bottle")
            }
        }
    }
}