package com.aeltumn.realms.common

import io.github.ayfri.kore.functions.Function

/** A feature that need setup. */
public interface Setuppable {

    public companion object {
        /** Applies all [settupables] to [function]. */
        public fun apply(function: Function, vararg settupables: Setuppable) {
            for (feature in settupables) {
                feature.apply {
                    function.setup()
                }
            }
        }
    }

    /** Sets up this feature. */
    public fun Function.setup()
}