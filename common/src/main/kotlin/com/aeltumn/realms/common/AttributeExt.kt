package com.aeltumn.realms.common

import io.github.ayfri.kore.arguments.types.EntityArgument
import io.github.ayfri.kore.arguments.types.literals.float
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.resources.AttributeArgument
import io.github.ayfri.kore.commands.AttributeModifierOperation
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.functions.Function
import java.util.UUID

/** Adds an attribute [id] to [target] of [attribute]. */
public fun Function.addAttribute(target: EntityArgument, attribute: AttributeArgument, id: String, value: Float, operation: AttributeModifierOperation): Command =
    addLine(
        command(
            "attribute",
            target,
            attribute,
            literal("modifier"),
            literal("add"),
            literal(id),
            float(value),
            literal(operation.name.lowercase())
        )
    )

/** Removes an attribute [id] from [target] of [attribute]. */
public fun Function.removeAttribute(target: EntityArgument, attribute: AttributeArgument, id: String): Command =
    addLine(command("attribute", target, attribute, literal("modifier"), literal("remove"), literal(id)))