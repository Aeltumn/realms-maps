package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.relativePos
import io.github.ayfri.kore.arguments.numbers.worldPos
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.tag

/** Sets up the shooting range. */
public object ShootingRange {

    /** Configures shooting range. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            tick("detect_shooting_range") {
                // Detect entering shooting range
                execute {
                    asTarget(
                        allPlayers {
                            tag = !CrossfireTags.SHOOTING_RANGE

                            scores {
                                score(CrossfireScoreboards.TARGET_MAP_INDEX) equalTo 0
                            }
                        }
                    )
                    at(self())
                    ifCondition {
                        block(vec3(0.relativePos, 88.worldPos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("red_glazed_terracotta"))
                    }

                    run {
                        tag(self()) {
                            add(CrossfireTags.RELOAD_CROSSBOW)
                            add(CrossfireTags.SHOOTING_RANGE)
                        }
                    }
                }

                // Detect leaving shooting range
                execute {
                    asTarget(
                        allPlayers {
                            tag = CrossfireTags.SHOOTING_RANGE
                        }
                    )
                    at(self())
                    ifCondition {
                        block(vec3(0.relativePos, 88.worldPos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("light_blue_glazed_terracotta"))
                    }

                    run {
                        // Take away tags
                        tag(self()) {
                            remove(CrossfireTags.RELOAD_CROSSBOW)
                            remove(CrossfireTags.SHOOTING_RANGE)
                        }

                        // End reload early
                        function(References.NAMESPACE, Crossbows.CANCEL_RELOAD)
                    }
                }
            }
        }
    }
}