package com.aeltumn.realms.common

import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.bossBars
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.functions.Function

/** Sets the players of this boss bar to nothing. */
public fun Function.clearBossBarPlayers(
    id: String,
    namespace: String = "minecraft",
): Command = addLine(command("bossbar", literal("set"), bossBars.get(id, namespace).id, literal("players")))

/** Sets the name of this boss bar to [name]. */
public fun Function.setBossBarName(
    id: String,
    namespace: String = "minecraft",
    name: ChatComponents
): Command = addLine(command("bossbar", literal("set"), bossBars.get(id, namespace).id, literal("name"), name.asJsonArg()))