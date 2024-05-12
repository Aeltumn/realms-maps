package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.arguments.colors.FormattingColor

/** For general crossfire references. */
public object References {

    /** The namespace used. */
    public val NAMESPACE: String = "crossfire"

    /** The different map identifiers. */
    public val MAPS: List<String> = listOf("duel", "party")

    /** The different timer types. */
    public val TIMER_TYPES: List<String> = listOf("start", "game", "post_game")

    /** All teams used in Crossfire. */
    public val TEAMS: Map<String, Map<String, FormattingColor>> = mapOf(
        "party" to mapOf(
            "red" to FormattingColor.RED,
            "yellow" to FormattingColor.YELLOW,
            "green" to FormattingColor.GREEN,
            "blue" to FormattingColor.BLUE,
        ),
        "duel" to mapOf(
            "orange" to FormattingColor.GOLD,
            "magenta" to FormattingColor.LIGHT_PURPLE,
        )
    )

    /** The names of all known teams. */
    public val TEAM_NAMES: List<String> = TEAMS.values.flatMap { it.keys }

    /** Returns the name to display for [team]. */
    public fun getDisplayNameForTeam(team: String): String =
        team.substring(0, 1).uppercase() + team.substring(1).lowercase()
}