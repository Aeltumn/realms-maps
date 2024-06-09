package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.common.Configurable
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.types.resources.EffectArgument
import io.github.ayfri.kore.arguments.types.resources.PredicateArgument
import io.github.ayfri.kore.features.predicates.conditions.entityProperties
import io.github.ayfri.kore.features.predicates.predicate
import io.github.ayfri.kore.features.predicates.sub.Effect
import io.github.ayfri.kore.features.predicates.sub.effects
import io.github.ayfri.kore.features.predicates.types.EntityType

/** Defines crossfire's predicates. */
public object CrossfirePredicates : Configurable {

    /** Whether a player has the multishot effect. */
    public lateinit var HAS_MULTISHOT: PredicateArgument

    /** Whether a player has the rapid fire effect. */
    public lateinit var HAS_RAPID_FIRE: PredicateArgument

    override fun DataPack.configure() {
        // Add predicates for detecting power-ups
        HAS_MULTISHOT = predicate("has_multishot") {
            entityProperties(EntityType.THIS) {
                effects {
                    put(EffectArgument("luck"), Effect())
                }
            }
        }

        HAS_RAPID_FIRE = predicate("has_rapid_fire") {
            entityProperties(EntityType.THIS) {
                effects {
                    put(EffectArgument("unluck"), Effect())
                }
            }
        }
    }
}