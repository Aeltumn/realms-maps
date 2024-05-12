package com.aeltumn.realms.crossfire.component

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
public object CrossfireScoreboards {

    public const val GAME_TIMER: String = "game_timer"
    public const val POST_GAME_TIMER: String = "post_game_timer"
    public const val DEAD_TIMER: String = "dead_timer"
    public const val START_TIMER: String = "start_timer"
    public const val TIMER: String = "timer"

    public const val STARTED: String = "started"
    public const val PLAYER: String = "player"
    public const val JOINED: String = "joined"
    public const val AGE: String = "age"
    public const val ROUND: String = "round"
    public const val RESULT: String = "result"
    public const val SONG: String = "song"
    public const val WINS: String = "wins"
    public const val WINNER: String = "winner"
    public const val BAR: String = "bar"
    public const val KILLS: String = "kills"

    public const val RESPAWN_SHIELD: String = "respawn_shield"
    public const val SPECTATE_SUCCESS: String = "spectate_success"
    public const val IS_RELOADING: String = "is_reloading"
    public const val INTRO_COMPLETED: String = "intro_completed"

    public const val ITEM_TELEPORT_1: String = "item_teleport_1"
    public const val ITEM_TELEPORT_2: String = "item_teleport_2"
    public const val ITEM_LEAVE: String = "item_leave"
    public const val ITEM_CROSSBOW: String = "item_crossbow"

    public const val INTRO: String = "intro"
    public const val INTRO_START_TRIGGER: String = "intro_start"
    public const val INTRO_SKIPPED_TRIGGER: String = "intro_skipped"

    public const val ITEM_USE_CROSSBOW: String = "item_use_crossbow"
    public const val ITEM_USE_POWER_UP: String = "item_use_power_up"

    /** Stores the actual round kills of each player. */
    public const val ROUND_KILLS: String = "round_kills"

    /** The map that a player is meant to be in at this time. */
    public const val TARGET_MAP_INDEX: String = "target_map_index"

    /** A cooldown before the map switch button can be used again. */
    public const val MAP_SWITCH_COOLDOWN: String = "cooldown"

    /** Sets up the scoreboards. */
    public fun setup(function: Function) {
        function.apply {
            // Reset all previous scoreboards
            ScoreboardDisplay.resetAll()

            // Create all dummy objectives
            for (objective in listOf(
                GAME_TIMER,
                POST_GAME_TIMER,
                DEAD_TIMER,
                START_TIMER,
                TIMER,
                STARTED,
                PLAYER,
                JOINED,
                AGE,
                ROUND,
                RESULT,
                TARGET_MAP_INDEX,
                SONG,
                WINS,
                MAP_SWITCH_COOLDOWN,
                WINNER,
                BAR,
                RESPAWN_SHIELD,
                ROUND_KILLS,
                SPECTATE_SUCCESS,
                IS_RELOADING,
                INTRO_COMPLETED,
                ITEM_TELEPORT_1,
                ITEM_TELEPORT_2,
                ITEM_LEAVE,
                ITEM_CROSSBOW,
                INTRO
            )) {
                scoreboard.objectives.add(objective, ScoreboardCriteria.DUMMY)
            }

            // Create trigger objectives
            scoreboard.objectives.add(INTRO_START_TRIGGER, ScoreboardCriteria.TRIGGER)
            scoreboard.objectives.add(INTRO_SKIPPED_TRIGGER, ScoreboardCriteria.TRIGGER)

            // Create item use objectives
            scoreboard.objectives.add(ITEM_USE_CROSSBOW, criteriaStat(StatisticTypes.USED, StatisticArgument("crossbow")))
            scoreboard.objectives.add(ITEM_USE_POWER_UP, criteriaStat(StatisticTypes.USED, StatisticArgument("carrot_on_a_stick")))

            // Create the kills objective
            scoreboard {
                objectives {
                    add(KILLS, ScoreboardCriteria.DUMMY, textComponent("Kills"))
                    setDisplay(DisplaySlots.belowName, KILLS)
                    setDisplay(DisplaySlots.list, KILLS)
                }
            }
        }
    }
}