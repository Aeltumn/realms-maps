package com.aeltumn.realms.common

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.maths.Vec3
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.relativePos
import io.github.ayfri.kore.functions.Function
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.functions.setTag
import kotlinx.serialization.Serializable

/** A position at ~ ~ ~. */
public val AT_POSITION: Vec3
    get() = vec3(0.relativePos, 0.relativePos, 0.relativePos)

/** Creates a new function that is added to the load tag. */
public fun DataPack.load(name: String, block: Function.() -> Unit) {
    function(name) {
        setTag(tagFile = "load", tagNamespace = "minecraft")
        block()
    }
}

/** Creates a new function that is added to the tick tag. */
public fun DataPack.tick(name: String, block: Function.() -> Unit) {
    function(name) {
        setTag(tagFile = "tick", tagNamespace = "minecraft")
        block()
    }
}