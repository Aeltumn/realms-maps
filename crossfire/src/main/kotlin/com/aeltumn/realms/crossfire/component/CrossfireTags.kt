package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.common.Configurable
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.features.tags.tag

/** Defines basic tags for crossfire. */
public object CrossfireTags : Configurable {

    // -- Tags added to entities
    /** For players that have been initialized. */
    public const val INITIALIZED: String = "initialized"

    /** For players that have joined a game. */
    public const val JOINED: String = "joined"

    /** For players that died from touching water. */
    public const val DIED_IN_WATER: String = "died_in_water"

    /** For players that recently died. */
    public const val DIED: String = "died"

    /** For players that should be in the spectating sequence. */
    public const val SPECTATING: String = "spectating"

    /** Base for tags given out when selecting a player to play in the game. */
    public const val SELECTED: String = "selected"

    /** Base for tags given out when playing as player slot. */
    public const val PLAYER: String = "player"

    /** Base for tags given out when spectating specific players. */
    public const val SPECTATE_PLAYER: String = "spectate_player"

    /** For players in the shooting range. */
    public const val SHOOTING_RANGE: String = "shooting_range"

    /** Indicates that a player should get their team colored crossbow. */
    public const val GIVE_CROSSBOW: String = "give_crossbow"

    /** Indicates a player's crossbow should reload if possible. */
    public const val RELOAD_CROSSBOW: String = "reload_crossbow"

    /** Indicates a player has their crossbow loaded. */
    public const val HAS_CROSSBOW_LOADED: String = "has_crossbow_loaded"

    /** Indicates a player's crossbow has multishot loaded. */
    public const val HAS_MULTISHOT_LOADED: String = "has_multishot_loaded"

    // -- Tags that define items

    /** Contains just the crossbow. */
    public const val CROSSBOW: String = "crossbow"

    /** All items that are illegal for non-admins to have. */
    public const val ILLEGAL_ITEMS: String = "illegal_items"

    // -- Tags added to entities

    /** For copters with supply crates. */
    public const val SUPPLY_CRATE: String = "supply_crate"

    /** For copters with any crate. */
    public const val CRATE: String = "crate"

    /** For copters that are now crateless. */
    public const val CRATELESS: String = "crateless"

    /** For copters that dropped their crate. */
    public const val DROPPED: String = "dropped"

    override fun DataPack.configure() {
        tag(CROSSBOW, "items") {
            add("minecraft:crossbow")
        }

        tag(ILLEGAL_ITEMS, "items") {
            add("minecraft:arrow")
            add("minecraft:glass_bottle")
        }
    }
}