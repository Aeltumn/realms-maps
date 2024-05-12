package com.aeltumn.realms.crossfire

import io.github.ayfri.kore.commands.schedules
import io.github.ayfri.kore.functions.Function

/** Manages crossfire's timers. */
public object CrossfireTimers {

    /** Sets up the timers. */
    public fun setup(function: Function) {
        function.apply {
            for (map in References.MAPS) {
                for (timer in References.TIMER_TYPES) {
                    val id = TimerIdentifier(map, timer)
                    schedules.clear(id.id)
                }
            }
        }
    }
}