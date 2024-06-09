package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.common.Setuppable
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.TimerIdentifier
import io.github.ayfri.kore.commands.schedules
import io.github.ayfri.kore.functions.Function

/** Manages crossfire's timers. */
public object CrossfireTimers : Setuppable {

    override fun Function.setup() {
        for (map in References.MAPS) {
            for (timer in References.TIMER_TYPES) {
                val id = TimerIdentifier(map, timer)
                schedules.clear(id.id)
            }
        }
    }
}