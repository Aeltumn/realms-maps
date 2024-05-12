package com.aeltumn.realms.common

import io.github.ayfri.kore.arguments.maths.Vec3
import io.github.ayfri.kore.arguments.types.EntityArgument
import io.github.ayfri.kore.arguments.types.literals.float
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.functions.Function

/** Plays a user-defined sound. */
public fun Function.playSound(
    sound: String,
    source: String? = null,
    target: EntityArgument? = null,
    pos: Vec3? = null,
    volume: Double? = null,
    pitch: Double? = null,
    minVolume: Double? = null,
): Command = addLine(command("playsound", literal(sound), source?.let { literal(it) }, target, pos, volume?.let { float(it) }, pitch?.let { float(it) }, minVolume?.let { float(it) }))