package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.common.Setuppable
import io.github.ayfri.kore.arguments.DisplaySlots
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.scores.ScoreboardCriteria
import io.github.ayfri.kore.arguments.scores.criteriaStat
import io.github.ayfri.kore.arguments.types.resources.StatisticArgument
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.functions.Function
import io.github.ayfri.kore.generated.StatisticTypes
import io.github.ayfri.kore.helpers.ScoreboardDisplay

/** Manages crossfire's scoreboards. */
public object CrossfireScoreboards : Setuppable {

    public const val GAME_STATE: String = "game_state"
    public const val GAME_TIMER: String = "game_timer"
    public const val POST_GAME_TIMER: String = "post_game_timer"
    public const val DEAD_TIMER: String = "dead_timer"
    public const val START_TIMER: String = "start_timer"
    public const val RELOAD_TIMER: String = "reload_timer"

    public const val STARTED: String = "started"
    public const val PLAYER: String = "player"
    public const val JOINED: String = "joined"
    public const val AGE: String = "age"
    public const val SONG: String = "song"
    public const val WINS: String = "wins"
    public const val WINNER: String = "winner"

    /** Shows the current kills of teams. */
    public const val TEAM_KILLS: String = "team_kills"

    /** Shows the lifetime kills of players. */
    public const val LIFETIME_KILLS: String = "lifetime_kills"

    public const val RESPAWN_SHIELD: String = "respawn_shield"
    public const val SUCCESS: String = "success"
    public const val SPECTATE_SUCCESS: String = "spectate_success"
    public const val IS_RELOADING: String = "is_reloading"
    public const val INTRO_COMPLETED: String = "intro_completed"
    public const val JUST_GOT_SPAMMED: String = "just_got_spammed"

    public const val ITEM_COUNT: String = "item_count"
    public const val PLAYER_COUNT: String = "player_count"
    public const val TEAM_COUNT: String = "team_count"

    public const val SELECTED_RANDOM: String = "selected_random"

    public const val INTRO: String = "intro"
    public const val INTRO_START_TRIGGER: String = "intro_start"
    public const val INTRO_SKIPPED_TRIGGER: String = "intro_skipped"

    public const val ITEM_USE_CROSSBOW: String = "item_use_crossbow"
    public const val ITEM_USE_CARROT_STICK: String = "item_use_carrot_stick"

    /** Stores the actual round kills of each player and team. */
    public const val ROUND_KILLS: String = "round_kills"

    /** The map that a player is meant to be in at this time. */
    public const val TARGET_MAP_INDEX: String = "target_map_index"

    /** A cooldown before the map switch button can be used again. */
    public const val MAP_SWITCH_COOLDOWN: String = "cooldown"

    override fun Function.setup() {
        // Reset all previous scoreboards
        ScoreboardDisplay.resetAll()

        // Create all dummy objectives
        for (objective in listOf(
            GAME_STATE,
            GAME_TIMER,
            POST_GAME_TIMER,
            DEAD_TIMER,
            START_TIMER,
            RELOAD_TIMER,
            STARTED,
            PLAYER,
            JOINED,
            AGE,
            TARGET_MAP_INDEX,
            SONG,
            WINS,
            MAP_SWITCH_COOLDOWN,
            WINNER,
            RESPAWN_SHIELD,
            ROUND_KILLS,
            SUCCESS,
            SPECTATE_SUCCESS,
            IS_RELOADING,
            INTRO_COMPLETED,
            ITEM_COUNT,
            PLAYER_COUNT,
            TEAM_COUNT,
            SELECTED_RANDOM,
            INTRO,
            JUST_GOT_SPAMMED
        )) {
            scoreboard.objectives.add(objective, ScoreboardCriteria.DUMMY)
        }

        // Create trigger objectives
        scoreboard.objectives.add(INTRO_START_TRIGGER, ScoreboardCriteria.TRIGGER)
        scoreboard.objectives.add(INTRO_SKIPPED_TRIGGER, ScoreboardCriteria.TRIGGER)

        // Create item use objectives
        scoreboard.objectives.add(ITEM_USE_CROSSBOW, criteriaStat(StatisticTypes.USED, StatisticArgument("crossbow")))
        scoreboard.objectives.add(ITEM_USE_CARROT_STICK, criteriaStat(StatisticTypes.USED, StatisticArgument("carrot_on_a_stick")))

        // Create the kills objective
        scoreboard {
            objectives {
                add(TEAM_KILLS, ScoreboardCriteria.DUMMY, textComponent("Score"))
                add(LIFETIME_KILLS, ScoreboardCriteria.DUMMY, textComponent("Kills"))
                setDisplay(DisplaySlots.belowName, LIFETIME_KILLS)
                setDisplay(DisplaySlots.list, LIFETIME_KILLS)
                setDisplay(DisplaySlots.sidebar, TEAM_KILLS)
            }
        }
    }
}