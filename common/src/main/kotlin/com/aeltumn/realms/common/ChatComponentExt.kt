package com.aeltumn.realms.common

import io.github.ayfri.kore.arguments.chatcomponents.ChatComponent
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents

/** Collects this component into a [ChatComponents] combination. */
public fun ChatComponent.collect(): ChatComponents =
    ChatComponents(mutableListOf(this))

/** Collects this component into a [ChatComponents] combination. */
public fun Iterable<ChatComponent>.collect(): ChatComponents =
    ChatComponents(toMutableList())