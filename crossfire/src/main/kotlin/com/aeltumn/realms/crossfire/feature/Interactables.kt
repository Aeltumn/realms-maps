package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.executeIfHolding
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.WEAPON
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.effect
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.functions.tick
import io.github.ayfri.kore.generated.Effects
import net.benwoodworth.knbt.NbtCompound
import net.benwoodworth.knbt.NbtInt
import net.benwoodworth.knbt.NbtString

/** Sets up carrot on a stick interactables. */
public object Interactables : Configurable {

    override fun DataPack.configure() {
        tick("detect_interactable_usage") {
            execute {
                asTarget(allPlayers {
                    scores {
                        score(CrossfireScoreboards.ITEM_USE_CARROT_STICK) greaterThanOrEqualTo 1
                    }
                })

                run {
                    // Reset their item use score
                    scoreboard.players.set(self(), CrossfireScoreboards.ITEM_USE_CARROT_STICK, 0)

                    // Rapid Fire
                    executeIfHolding(
                        NbtCompound(mapOf(
                            "id" to NbtString("minecraft:carrot_on_a_stick"),
                            "components" to NbtCompound(mapOf(
                                "minecraft:custom_model_data" to NbtInt(0)
                            ))
                        ))
                    ) {
                        effect(self()) {
                            give(Effects.UNLUCK, 20, 0)
                        }
                        playSound(SoundArgument("item.armor.equip_diamond", "minecraft"), PlaySoundMixer.PLAYER, self(), AT_POSITION)
                        items {
                            replace(self(), WEAPON.MAINHAND, item("air"))
                        }
                    }

                    // Multi-shot
                    executeIfHolding(
                        NbtCompound(mapOf(
                            "id" to NbtString("minecraft:carrot_on_a_stick"),
                            "components" to NbtCompound(mapOf(
                                "minecraft:custom_model_data" to NbtInt(1)
                            ))
                        ))
                    ) {
                        effect(self()) {
                            give(Effects.LUCK, 20, 0)
                        }
                        playSound(SoundArgument("item.armor.equip_diamond", "minecraft"), PlaySoundMixer.PLAYER, self(), AT_POSITION)
                        items {
                            replace(self(), WEAPON.MAINHAND, item("air"))
                        }
                    }

                    // Map Switch
                    executeIfHolding(
                        NbtCompound(mapOf(
                            "id" to NbtString("minecraft:carrot_on_a_stick"),
                            "components" to NbtCompound(mapOf(
                                "minecraft:custom_model_data" to NbtInt(2)
                            ))
                        ))
                    ) {
                        // Party -> Duel
                        scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 1)
                        function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
                    }
                    executeIfHolding(
                        NbtCompound(mapOf(
                            "id" to NbtString("minecraft:carrot_on_a_stick"),
                            "components" to NbtCompound(mapOf(
                                "minecraft:custom_model_data" to NbtInt(3)
                            ))
                        ))
                    ) {
                        // Duel -> Party
                        scoreboard.players.set(self(), CrossfireScoreboards.TARGET_MAP_INDEX, 0)
                        function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
                    }

                    // Quit Game
                    executeIfHolding(
                        NbtCompound(mapOf(
                            "id" to NbtString("minecraft:carrot_on_a_stick"),
                            "components" to NbtCompound(mapOf(
                                "minecraft:custom_model_data" to NbtInt(4)
                            ))
                        ))
                    ) {
                        function(References.NAMESPACE, ManagePlayers.RESET_PLAYER_FUNCTION)
                    }
                }
            }
        }
    }
}