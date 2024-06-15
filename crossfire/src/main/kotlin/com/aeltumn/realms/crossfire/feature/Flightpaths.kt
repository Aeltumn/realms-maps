package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.numbers.relativeRot
import io.github.ayfri.kore.arguments.numbers.rot
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tp

/** Moves around flying entities. */
public object Flightpaths : Configurable {

    override fun DataPack.configure() {
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
        }
    }
}