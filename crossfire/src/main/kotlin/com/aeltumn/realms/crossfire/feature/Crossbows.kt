package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.CONTAINER
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.components.types.itemName
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.arguments.types.resources.tagged.ItemTagArgument
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.functions.tick
import io.github.ayfri.kore.generated.EntityTypes
import net.benwoodworth.knbt.NbtCompound
import net.benwoodworth.knbt.NbtString

/** Sets up the crossbow mechanic as well as inventory items in general. */
public object Crossbows {

    /** Function that cancels a crossbow reloading. */
    public const val CANCEL_RELOAD: String = "cancel_reload"

    /** Configures the crossbow mechanic. */
    public fun configure(dataPack: DataPack) {
        dataPack.apply {
            val emptyCrossbowItem = item("crossbow") {
                itemName("Empty Crossbow", color = Color.DARK_GRAY)
            }

            // Updates crossbows in inventories
            tick("update_crossbows") {
                // Kill all dropped items
                fun killAllDropped(id: String) {

                    kill(allEntities {
                        type = EntityTypes.ITEM
                        nbt = NbtCompound(
                            mapOf(
                                "Item" to NbtCompound(
                                    mapOf(
                                        "id" to NbtString(id)
                                    )
                                )
                            )
                        )
                    })
                }

                killAllDropped("minecraft:crossbow")
                killAllDropped("minecraft:carrot_on_a_stick")
                killAllDropped("minecraft:potion")
                killAllDropped("minecraft:glass_bottle")

                // Take away all illegal items
                addLine(
                    command(
                        "clear",
                        allPlayers {
                            tag = !CrossfireTags.ADMIN
                        },
                        ItemTagArgument(CrossfireTags.ILLEGAL_ITEMS, References.NAMESPACE)
                    )
                )

                // Take away tags for getting crossbows from admins and spectators
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.GIVE_CROSSBOW
                        }
                    )
                    unlessCondition {
                        entity(
                            self {
                                tag = !CrossfireTags.SPECTATING
                                tag = !CrossfireTags.DIED
                                tag = !CrossfireTags.ADMIN
                            }
                        )
                    }
                    run {
                        tag(self()) {
                            remove(CrossfireTags.GIVE_CROSSBOW)
                        }
                    }
                }
                execute {
                    asTarget(
                        allEntities {
                            tag = CrossfireTags.RELOAD_CROSSBOW
                        }
                    )
                    unlessCondition {
                        entity(
                            self {
                                tag = !CrossfireTags.SPECTATING
                                tag = !CrossfireTags.DIED
                                tag = !CrossfireTags.ADMIN
                            }
                        )
                    }
                    run {
                        tag(self()) {
                            remove(CrossfireTags.RELOAD_CROSSBOW)
                        }
                    }
                }

                // Give out the map changer item properly
                
            }

            // A function which cancels the reload and resets the crossbow
            function(CANCEL_RELOAD) {
                scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
                scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)

                items.replace(self(), CONTAINER[1], emptyCrossbowItem, count = 1)
            }
        }
    }
}