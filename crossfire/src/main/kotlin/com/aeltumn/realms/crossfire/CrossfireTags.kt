package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.features.tags.tag

/** Defines basic tags for crossfire. */
public object CrossfireTags {

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