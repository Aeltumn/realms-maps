package com.aeltumn.realms.common

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.pack.filter

/** Sets up filters to remove base recipes & advancements. */
public fun DataPack.filterOutDefaults() {
    filter {
        block("minecraft", "recipes/.*")
        block("minecraft", "advancements/.*")
    }
}
