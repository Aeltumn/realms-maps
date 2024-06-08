package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.localPos
import io.github.ayfri.kore.arguments.numbers.relativeRot
import io.github.ayfri.kore.arguments.numbers.rot
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tp

/** Moves around flying entities. */
public object Flightpaths {

    /** Sets up flight paths for moving entities. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            tick("move_flying_entities") {
                // Rotate flight path entities
                execute {
                    asTarget(
                        allEntities {
                            tag = "flightpath5"
                        }
                    )
                    at(self())

                    run {
                        tp(self(), AT_POSITION, rotation(0.05.relativeRot, (-10.0).rot))
                    }
                }

                // Rotate sparkling entities
                execute {
                    asTarget(
                        allEntities {
                            tag = "sparkling"
                        }
                    )
                    run {
                        scoreboard.players.add(self(), CrossfireScoreboards.AGE, 1)
                    }
                }
                execute {
                    asTarget(
                        allEntities {
                            tag = "sparkling"
                        }
                    )
                    ifCondition {
                        data(self(), "{Marker:1b,NoGravity:1b}")
                    }
                    at(self())

                    run {
                        tp(self(), AT_POSITION, rotation(1.0.relativeRot, 0.0.rot))
                    }
                }

                // Make copters fly
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.SUPPLY_CRATE
                            tag = !CrossfireTags.CRATELESS
                        }
                    )
                    at(self())

                    run {
                        tp(self(), vec3(0.0.localPos, 0.0.localPos, 0.2.localPos), rotation(2.0.relativeRot, 0.0.rot))
                    }
                }
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.CRATE
                            tag = !CrossfireTags.CRATELESS
                            tag = !CrossfireTags.DROPPED
                        }
                    )
                    at(self())

                    run {
                        tp(self(), vec3(0.0.localPos, 0.0.localPos, 0.2.localPos), rotation(2.0.relativeRot, 0.0.rot))
                    }
                }

                // If crateless make copter(/crate) fly up
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.CRATELESS
                        }
                    )
                    at(self())

                    run {
                        tp(self(), vec3(0.0.localPos, 0.2.localPos, 0.0.localPos))
                    }
                }

                // Kill crateless copters above y 75
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.CRATELESS
                        }
                    )
                    at(self())
                    ifCondition {
                        entity(self {
                            y = 120.0
                            dy = 1000.0
                        })
                    }

                    run {
                        kill(self())
                    }
                }
            }
        }
    }
}