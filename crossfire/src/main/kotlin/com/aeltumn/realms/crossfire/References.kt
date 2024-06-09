package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.colors.FormattingColor
import io.github.ayfri.kore.arguments.colors.rgb

/** For general crossfire references. */
public object References {

    /** The namespace used. */
    public const val NAMESPACE: String = "crossfire"

    /** The amount of players. */
    public const val PLAYER_COUNT: Int = 24

    /** The different map identifiers. */
    public val MAPS: List<String> = listOf("party", "duel")

    /** The different timer types. */
    public val TIMER_TYPES: List<String> = listOf("start", "game", "post_game")

    /** All teams used in Crossfire. */
    public val TEAMS: Map<String, Map<String, FormattingColor>> = mapOf(
        "party" to mapOf(
            "red" to FormattingColor.RED,
            "yellow" to FormattingColor.YELLOW,
            "lime" to FormattingColor.GREEN,
            "light_blue" to FormattingColor.BLUE,
        ),
        "duel" to mapOf(
            "orange" to FormattingColor.GOLD,
            "magenta" to FormattingColor.LIGHT_PURPLE,
        )
    )

    /** The names of all known teams. */
    public val TEAM_NAMES: List<String> = TEAMS.values.flatMap { it.keys }

    /** Returns the color to use for [team]. */
    public fun getColorForTeam(team: String): Color = when (team) {
        "red" -> Color.RED
        "yellow" -> Color.YELLOW
        "lime" -> Color.GREEN
        "light_blue" -> Color.AQUA
        "orange" -> Color.GOLD
        "magenta" -> Color.LIGHT_PURPLE
        else -> Color.BLACK
    }

    /** Returns the armor color to use for [team]. */
    public fun getArmorColorForTeam(team: String): Color = rgb(
        when (team) {
            "red" -> 14352389
            "yellow" -> 16770580
            "lime" -> 1572623
            "light_blue" -> 1363455
            "orange" -> 16082432
            "magenta" -> 14549237
            else -> 0
        }
    )

    /** Returns the display icon to use for [team]. */
    public fun getDisplayIconForTeam(team: String): String =
        when (team) {
            "red" -> "\uE003"
            "yellow" -> "\uE001"
            "lime" -> "\uE000"
            "light_blue" -> "\uE002"
            "orange" -> "\uE011"
            "magenta" -> "\uE012"
            else -> ""
        }

    /** Returns the name to display for [team]. */
    public fun getDisplayNameForTeam(team: String): String {
        if (team == "light_blue") return "Blue"
        if (team == "lime") return "Green"
        return team.substring(0, 1).uppercase() + team.substring(1).lowercase()
    }

    /** Returns the names of the teams in [map]. */
    public fun getTeamNames(map: String): List<String> =
        TEAMS.getOrDefault(map, emptyMap()).keys.toList()
}