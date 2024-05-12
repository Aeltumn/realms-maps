package com.aeltumn.realms.crossfire.component

import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.types.resources.EffectArgument
import io.github.ayfri.kore.features.predicates.conditions.entityProperties
import io.github.ayfri.kore.features.predicates.predicate
import io.github.ayfri.kore.features.predicates.sub.Effect
import io.github.ayfri.kore.features.predicates.sub.effects
import io.github.ayfri.kore.features.predicates.types.EntityType

/** Defines crossfire's predicates. */
public object CrossfirePredicates {

    /** Configures the predicates. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            // Add predicates for detecting power-ups
            predicate("has_multishot") {
                entityProperties(EntityType.THIS) {
                    effects {
                        put(EffectArgument("luck"), Effect())
                    }
                }
            }
            predicate("has_rapid_fire") {
                entityProperties(EntityType.THIS) {
                    effects {
                        put(EffectArgument("unluck"), Effect())
                    }
                }
            }
        }
    }
}