package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.arguments.colors.FormattingColor

/** For general crossfire references. */
public object References {

    /** The namespace used. */
    public val NAMESPACE: String = "crossfire"

    /** The different map identifiers. */
    public val MAPS: List<String> = listOf("2", "4")

    /** The different timer types. */
    public val TIMER_TYPES: List<String> = listOf("0", "2", "3")

    /** All teams used in Crossfire. */
    public val TEAMS: Map<String, Map<String, FormattingColor>> = mapOf(
        "2" to mapOf(
            "red" to FormattingColor.RED,
            "yellow" to FormattingColor.YELLOW,
            "green" to FormattingColor.GREEN,
            "blue" to FormattingColor.BLUE,
        ),
        "4" to mapOf(
            "orange" to FormattingColor.GOLD,
            "magenta" to FormattingColor.LIGHT_PURPLE,
        )
    )
}