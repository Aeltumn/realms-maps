package com.aeltumn.realms.common

import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.functions.Function
import net.benwoodworth.knbt.NbtCompound

/** Executes [function] if [score] equals [value]. */
public fun Function.executeIfEqualTo(score: String, value: Int, function: Function.() -> Command): Command =
    execute {
        ifCondition { score(self(), score) equalTo value }
        run(function)
    }

/** Executes [function] if [score] is greater than or equal to [value]. */
public fun Function.executeIfGreaterThanOrEqualTo(score: String, value: Int, function: Function.() -> Command): Command =
    execute {
        ifCondition { score(self(), score) greaterThanOrEqualTo value }
        run(function)
    }

/** Executes [function] if [score] is greater than or equal to [value]. */
public fun Function.executeIfHolding(item: NbtCompound, function: Function.() -> Command): Command =
    execute {
        ifCondition {
            entity(self {
                nbt = NbtCompound(
                    mapOf(
                        "SelectedItem" to item
                    )
                )
            })
        }
        run(function)
    }