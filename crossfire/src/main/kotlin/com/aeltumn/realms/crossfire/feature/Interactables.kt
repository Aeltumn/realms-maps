package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.functions.tick

/** Sets up carrot on a stick interactables. */
public object Interactables : Configurable {

    override fun DataPack.configure() {
        tick("detect_interactable_usage") {

        }
    }
}