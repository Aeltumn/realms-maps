package com.aeltumn.realms.common

import io.github.ayfri.kore.DataPack

/** A feature implemented on a data pack. */
public interface Configurable {

    public companion object {
        /** Applies all [configurables] to [dataPack]. */
        public fun apply(dataPack: DataPack, vararg configurables: Configurable) {
            for (feature in configurables) {
                feature.apply {
                    dataPack.configure()
                }
            }
        }
    }

    /** Configures this feature. */
    public fun DataPack.configure()
}