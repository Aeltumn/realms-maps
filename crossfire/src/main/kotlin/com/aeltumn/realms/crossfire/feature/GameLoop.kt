package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.crossfire.References
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.commands.say
import io.github.ayfri.kore.functions.function

/** Sets up the main game loop. */
public object GameLoop : Configurable {

    override fun DataPack.configure() {
        for (map in References.MAPS) {
            // Start function triggered by button in map
            function("start-$map") {
                say("Starting $map")
            }
        }
    }
}