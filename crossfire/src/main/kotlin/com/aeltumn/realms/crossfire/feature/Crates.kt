package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.executeIfEqualTo
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.CONTAINER
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.events.HoverAction
import io.github.ayfri.kore.arguments.chatcomponents.events.showText
import io.github.ayfri.kore.arguments.chatcomponents.hoverEvent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.components.types.customModelData
import io.github.ayfri.kore.arguments.components.types.itemName
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.localPos
import io.github.ayfri.kore.arguments.numbers.ranges.rangeEnd
import io.github.ayfri.kore.arguments.numbers.ranges.rangeOrInt
import io.github.ayfri.kore.arguments.numbers.relativePos
import io.github.ayfri.kore.arguments.numbers.relativeRot
import io.github.ayfri.kore.arguments.numbers.rot
import io.github.ayfri.kore.arguments.numbers.worldPos
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.rotation
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.ParticleArgument
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.data
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.particle.particle
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.randomValue
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.summon
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.tp
import io.github.ayfri.kore.functions.Function
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.generated.ComponentTypes
import io.github.ayfri.kore.generated.EntityTypes
import io.github.ayfri.kore.generated.Particles
import net.benwoodworth.knbt.NbtByte
import net.benwoodworth.knbt.NbtCompound
import net.benwoodworth.knbt.NbtInt
import net.benwoodworth.knbt.NbtList
import net.benwoodworth.knbt.NbtString

/** Sets up crates. */
public object Crates : Configurable {

    public const val SPAWN_IRON: String = "spawn_iron"
    public const val SPAWN_GOLD: String = "spawn_gold"
    public const val OPEN_CRATE: String = "open_crate"

    override fun DataPack.configure() {
        // Spawn functions per map
        for ((index, map) in References.MAPS.withIndex()) {
            function("${SPAWN_IRON}-$map") {
                // Spawn the crate itself
                summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                    put("Tags", NbtList(listOf(NbtString("iron"), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"), NbtString(CrossfireTags.CRATE))))
                    put("NoGravity", NbtByte(1))
                    put("Invisible", NbtByte(1))
                    put("Marker", NbtByte(1))
                    put(
                        "ArmorItems", NbtList(
                            listOf(
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(
                                    mapOf(
                                        "id" to NbtString("gold_ingot"),
                                        "count" to NbtInt(10),
                                        "components" to NbtCompound(
                                            mapOf(
                                                "minecraft:custom_model_data" to NbtInt(3)
                                            )
                                        )
                                    )
                                ),
                            )
                        )
                    )
                }

                // Spawn the copter
                summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                    put("Tags", NbtList(listOf(NbtString("iron"), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"), NbtString(CrossfireTags.COPTER))))
                    put("NoGravity", NbtByte(1))
                    put("Invisible", NbtByte(1))
                    put("Marker", NbtByte(1))
                    put(
                        "ArmorItems", NbtList(
                            listOf(
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(
                                    mapOf(
                                        "id" to NbtString("gold_ingot"),
                                        "count" to NbtInt(10),
                                        "components" to NbtCompound(
                                            mapOf(
                                                "minecraft:custom_model_data" to NbtInt(4)
                                            )
                                        )
                                    )
                                ),
                            )
                        )
                    )
                }

                // Send a message about the spawning (plus sound)
                tellraw(
                    mapMembersSelector(index),
                    ChatComponents().apply {
                        plus(textComponent("An "))
                        plus(textComponent("iron crate", Color.GRAY))
                        plus(textComponent(" has appeared above the arena!"))
                    }
                )
                execute {
                    asTarget(mapMembersSelector(index))
                    at(self())
                    run {
                        playSound(SoundArgument("block.note_block.bit"), PlaySoundMixer.AMBIENT, self(), vec3(6.relativePos, 0.relativePos, 0.relativePos), 20.0, 1.0)
                    }
                }
            }
            function("${SPAWN_GOLD}-$map") {
                // Spawn the crate itself
                summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 91.worldPos, 0.relativePos)) {
                    put("Tags", NbtList(listOf(NbtString("gold"), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"), NbtString(CrossfireTags.CRATE))))
                    put("NoGravity", NbtByte(1))
                    put("Invisible", NbtByte(1))
                    put("Marker", NbtByte(1))
                    put(
                        "ArmorItems", NbtList(
                            listOf(
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(
                                    mapOf(
                                        "id" to NbtString("gold_ingot"),
                                        "count" to NbtInt(10),
                                        "components" to NbtCompound(
                                            mapOf(
                                                "minecraft:custom_model_data" to NbtInt(2)
                                            )
                                        )
                                    )
                                ),
                            )
                        )
                    )
                }

                // Spawn the copter
                summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 91.worldPos, 0.relativePos)) {
                    put("Tags", NbtList(listOf(NbtString("gold"), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"), NbtString(CrossfireTags.COPTER))))
                    put("NoGravity", NbtByte(1))
                    put("Invisible", NbtByte(1))
                    put("Marker", NbtByte(1))
                    put(
                        "ArmorItems", NbtList(
                            listOf(
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(emptyMap()),
                                NbtCompound(
                                    mapOf(
                                        "id" to NbtString("gold_ingot"),
                                        "count" to NbtInt(10),
                                        "components" to NbtCompound(
                                            mapOf(
                                                "minecraft:custom_model_data" to NbtInt(4)
                                            )
                                        )
                                    )
                                ),
                            )
                        )
                    )
                }

                // Send a message about the spawning (plus sound)
                tellraw(
                    mapMembersSelector(index),
                    ChatComponents().apply {
                        plus(textComponent("A "))
                        plus(textComponent("golden crate", Color.GOLD))
                        plus(textComponent(" has appeared above the arena!"))
                    }
                )
                execute {
                    asTarget(mapMembersSelector(index))
                    at(self())
                    run {
                        playSound(SoundArgument("block.note_block.bit"), PlaySoundMixer.AMBIENT, self(), vec3(6.relativePos, 0.relativePos, 0.relativePos), 20.0, 2.0)
                    }
                }
            }
        }

        // Flight path functions
        tick("crate_tick") {
            // Add age to copters, crates and power-ups
            scoreboard.players.add(allEntities { tag = CrossfireTags.POWER_UP }, CrossfireScoreboards.AGE, 1)
            scoreboard.players.add(allEntities { tag = CrossfireTags.CRATE }, CrossfireScoreboards.AGE, 1)
            scoreboard.players.add(allEntities { tag = CrossfireTags.COPTER }, CrossfireScoreboards.AGE, 1)

            // Kill power-ups after 50 seconds
            kill(
                allEntities {
                    tag = CrossfireTags.POWER_UP
                    scores {
                        score(CrossfireScoreboards.AGE) greaterThanOrEqualTo 1000
                    }
                }
            )

            // Make crates leave if they get too old
            execute {
                asTarget(allEntities {
                    tag = CrossfireTags.COPTER
                    tag = !CrossfireTags.READY_TO_DROP
                    tag = !CrossfireTags.LEFT_PAYLOAD
                    scores {
                        score(CrossfireScoreboards.AGE) greaterThanOrEqualTo 800
                    }
                })
                run {
                    tag(self()) {
                        add(CrossfireTags.LEFT_PAYLOAD)
                    }
                }
            }
            execute {
                asTarget(allEntities {
                    tag = CrossfireTags.CRATE
                    tag = !CrossfireTags.READY_TO_DROP
                    tag = !CrossfireTags.LEFT_PAYLOAD
                    scores {
                        score(CrossfireScoreboards.AGE) greaterThanOrEqualTo 800
                    }
                })
                run {
                    tag(self()) {
                        add(CrossfireTags.LEFT_PAYLOAD)
                    }
                }
            }

            // Make copters and crates rotate together
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.CRATE
                        tag = !CrossfireTags.DROPPED
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
                        tag = CrossfireTags.COPTER
                        tag = !CrossfireTags.LEFT_PAYLOAD
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
                        tag = CrossfireTags.LEFT_PAYLOAD
                    }
                )
                at(self())

                run {
                    tp(self(), vec3(0.0.relativePos, 0.2.relativePos, 0.0.relativePos))
                }
            }

            // Kill crateless entities above y 120
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.LEFT_PAYLOAD
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

            // Add particles, clouds for copter, lava on crate if it wants to leave
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.COPTER
                    }
                )
                at(self())

                run {
                    particle(Particles.CLOUD, vec3(0.relativePos, 2.5.relativePos, 0.relativePos), vec3(0.6.worldPos, 0.3.worldPos, 0.6.worldPos), 0.0, 1)
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.CRATE
                        tag = CrossfireTags.READY_TO_DROP
                        tag = !CrossfireTags.LEFT_PAYLOAD
                    }
                )
                at(self())

                run {
                    particle(Particles.LAVA, vec3(0.relativePos, 2.5.relativePos, 0.relativePos), vec3(0.3.worldPos, 0.5.worldPos, 0.3.worldPos), 0.0, 1)
                }
            }

            // Rotate sparkling entities and add sparkles
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.POWER_UP
                    }
                )
                ifCondition {
                    data(self(), "{Marker:1b,NoGravity:1b}")
                }
                at(self())

                run {
                    tp(self(), AT_POSITION, rotation(1.0.relativeRot, 0.0.rot))
                    particle(Particles.FIREWORK, vec3(0.relativePos, 0.2.relativePos, 0.relativePos), vec3(0.2.worldPos, 0.3.worldPos, 0.2.worldPos), 0.0, 1)
                }
            }

            // Make crates explode on floor impact
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.DROPPED
                    }
                )
                at(self())

                // Don't open if still mid-air!
                unlessCondition {
                    block(vec3(0.relativePos, (-1).relativePos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("air"))
                }

                positioned(vec3(0.5.relativePos, 0.relativePos, 0.5.relativePos))
                run {
                    function(References.NAMESPACE, OPEN_CRATE)
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.DROPPED

                        // If it's been 40 ticks we always open it up!
                        scores {
                            score(CrossfireScoreboards.AGE) greaterThanOrEqualTo 40
                        }
                    }
                )
                at(self())
                positioned(vec3(0.5.relativePos, 0.relativePos, 0.5.relativePos))
                run {
                    function(References.NAMESPACE, OPEN_CRATE)
                }
            }

            // Make copters drop payload if applicable
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.CRATE
                        tag = CrossfireTags.READY_TO_DROP
                        tag = !CrossfireTags.LEFT_PAYLOAD
                    }
                )
                at(self())
                ifCondition {
                    // Purple glazed terracotta indicates crates can be dropped here
                    block(vec3(0.relativePos, 0.worldPos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("purple_glazed_terracotta"))
                }

                run {
                    tag(self()) {
                        // Makes the crate stop rotating!
                        add(CrossfireTags.DROPPED)

                        // Make it not want to drop anymore
                        remove(CrossfireTags.READY_TO_DROP)
                    }

                    // Reset age so we can use it for fallback landed detection
                    scoreboard.players.set(self(), CrossfireScoreboards.AGE, 0)

                    // Make it be on the floor
                    data(self()) {
                        merge(
                            NbtCompound(
                                mapOf(
                                    "Marker" to NbtByte(0),
                                    "NoGravity" to NbtByte(0)
                                )
                            )
                        )
                    }
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.COPTER
                        tag = CrossfireTags.READY_TO_DROP
                        tag = !CrossfireTags.LEFT_PAYLOAD
                    }
                )
                at(self())
                ifCondition {
                    // Purple glazed terracotta indicates crates can be dropped here
                    block(vec3(0.relativePos, 0.worldPos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("purple_glazed_terracotta"))
                }

                run {
                    tag(self()) {
                        // Make it start leaving
                        add(CrossfireTags.LEFT_PAYLOAD)

                        // Make it not want to drop anymore
                        remove(CrossfireTags.READY_TO_DROP)
                    }
                }
            }
        }

        // Dropping crate items (executed as crate entity)
        function(OPEN_CRATE) {
            /** Handles a drop in [map] of the given type. */
            fun Function.handleDrop(gold: Boolean, map: String, index: Int): Command {
                // Kill the crate
                kill(self())

                // Spawn a random drop
                if (gold) {
                    execute {
                        storeResult {
                            score(literal(map), CrossfireScoreboards.SELECTED_RANDOM)
                        }
                        run {
                            randomValue(0..1)
                        }
                    }
                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 0, literal(map)) {
                        tellraw(
                            mapMembersSelector(index),
                            ChatComponents().apply {
                                plus(textComponent("The "))
                                plus(textComponent("Rapid Fire Power-up", Color.GOLD) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("Increases the user's fire rate tremendously."))
                                        }
                                    }
                                })
                                plus(textComponent(" power-up has been dropped by a shiny crate!"))
                            }
                        )

                        summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                            put("Tags", NbtList(listOf(NbtString("rapid_fire"), NbtString(CrossfireTags.POWER_UP), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"))))
                            put("Marker", NbtByte(1))
                            put("Invisible", NbtByte(1))
                            put(
                                "ArmorItems", NbtList(
                                    listOf(
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(
                                            mapOf(
                                                "id" to NbtString("carrot_on_a_stick"),
                                                "count" to NbtInt(1),
                                                "components" to NbtCompound(
                                                    mapOf(
                                                        "minecraft:custom_model_data" to NbtInt(0)
                                                    )
                                                )
                                            )
                                        ),
                                    )
                                )
                            )
                        }
                    }
                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 1, literal(map)) {
                        tellraw(
                            mapMembersSelector(index),
                            ChatComponents().apply {
                                plus(textComponent("The "))
                                plus(textComponent("Multishot Power-up", Color.LIGHT_PURPLE) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("Makes the user's crossbow shoot 3 arrows at a time."))
                                        }
                                    }
                                })
                                plus(textComponent(" power-up has been dropped by a shiny crate!"))
                            }
                        )

                        summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                            put("Tags", NbtList(listOf(NbtString("multishot"), NbtString(CrossfireTags.POWER_UP), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"))))
                            put("Marker", NbtByte(1))
                            put("Invisible", NbtByte(1))
                            put(
                                "ArmorItems", NbtList(
                                    listOf(
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(
                                            mapOf(
                                                "id" to NbtString("carrot_on_a_stick"),
                                                "count" to NbtInt(1),
                                                "components" to NbtCompound(
                                                    mapOf(
                                                        "minecraft:custom_model_data" to NbtInt(1)
                                                    )
                                                )
                                            )
                                        ),
                                    )
                                )
                            )
                        }
                    }
                } else {
                    execute {
                        storeResult {
                            score(literal(map), CrossfireScoreboards.SELECTED_RANDOM)
                        }
                        run {
                            randomValue(0..2)
                        }
                    }
                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 0, literal(map)) {
                        tellraw(
                            mapMembersSelector(index),
                            ChatComponents().apply {
                                plus(textComponent("The "))
                                plus(textComponent("Swiftness II Potion", Color.AQUA) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("Gives the user the Swiftness II potion effect for 20 seconds."))
                                        }
                                    }
                                })
                                plus(textComponent(" power-up has been dropped by a crate!"))
                            }
                        )

                        summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                            put("Tags", NbtList(listOf(NbtString("swiftness"), NbtString(CrossfireTags.POWER_UP), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"))))
                            put("Marker", NbtByte(1))
                            put("Invisible", NbtByte(1))
                            put(
                                "ArmorItems", NbtList(
                                    listOf(
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(
                                            mapOf(
                                                "id" to NbtString("potion"),
                                                "count" to NbtInt(1),
                                                "components" to NbtCompound(
                                                    mapOf(
                                                        "minecraft:potion_contents" to NbtCompound(
                                                            mapOf(
                                                                "custom_color" to NbtInt(10806260),
                                                                "custom_effects" to NbtList(
                                                                    listOf(
                                                                        NbtCompound(
                                                                            mapOf(
                                                                                "id" to NbtString("minecraft:speed"),
                                                                                "amplifier" to NbtInt(1),
                                                                                "duration" to NbtInt(400)
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        ),
                                    )
                                )
                            )
                        }
                    }
                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 1, literal(map)) {
                        tellraw(
                            mapMembersSelector(index),
                            ChatComponents().apply {
                                plus(textComponent("The "))
                                plus(textComponent("Jump Boost V Potion", Color.GREEN) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("Gives the user the Jump Boost V potion effect for 20 seconds."))
                                        }
                                    }
                                })
                                plus(textComponent(" power-up has been dropped by a crate!"))
                            }
                        )

                        summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                            put("Tags", NbtList(listOf(NbtString("jump_boost"), NbtString(CrossfireTags.POWER_UP), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"))))
                            put("Marker", NbtByte(1))
                            put("Invisible", NbtByte(1))
                            put(
                                "ArmorItems", NbtList(
                                    listOf(
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(
                                            mapOf(
                                                "id" to NbtString("potion"),
                                                "count" to NbtInt(1),
                                                "components" to NbtCompound(
                                                    mapOf(
                                                        "minecraft:potion_contents" to NbtCompound(
                                                            mapOf(
                                                                "custom_color" to NbtInt(1309504),
                                                                "custom_effects" to NbtList(
                                                                    listOf(
                                                                        NbtCompound(
                                                                            mapOf(
                                                                                "id" to NbtString("minecraft:jump_boost"),
                                                                                "amplifier" to NbtInt(4),
                                                                                "duration" to NbtInt(400)
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        ),
                                    )
                                )
                            )
                        }
                    }
                    executeIfEqualTo(CrossfireScoreboards.SELECTED_RANDOM, 2, literal(map)) {
                        tellraw(
                            mapMembersSelector(index),
                            ChatComponents().apply {
                                plus(textComponent("The "))
                                plus(textComponent("Slow Falling I Potion", Color.GRAY) {
                                    hoverEvent(HoverAction.SHOW_TEXT) {
                                        showText {
                                            plus(textComponent("Gives the user the Slow Falling I potion effect for 20 seconds."))
                                        }
                                    }
                                })
                                plus(textComponent(" power-up has been dropped by a crate!"))
                            }
                        )

                        summon(EntityTypes.ARMOR_STAND, vec3(6.relativePos, 85.worldPos, 0.relativePos)) {
                            put("Tags", NbtList(listOf(NbtString("slow_falling"), NbtString(CrossfireTags.POWER_UP), NbtString(map), NbtString("cleanup"), NbtString("cleanup-$map"))))
                            put("Marker", NbtByte(1))
                            put("Invisible", NbtByte(1))
                            put(
                                "ArmorItems", NbtList(
                                    listOf(
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(emptyMap()),
                                        NbtCompound(
                                            mapOf(
                                                "id" to NbtString("potion"),
                                                "count" to NbtInt(1),
                                                "components" to NbtCompound(
                                                    mapOf(
                                                        "minecraft:potion_contents" to NbtCompound(
                                                            mapOf(
                                                                "custom_color" to NbtInt(16777215),
                                                                "custom_effects" to NbtList(
                                                                    listOf(
                                                                        NbtCompound(
                                                                            mapOf(
                                                                                "id" to NbtString("minecraft:slow_falling"),
                                                                                "amplifier" to NbtInt(0),
                                                                                "duration" to NbtInt(400)
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        ),
                                    )
                                )
                            )
                        }
                    }
                }

                // Play effects
                particle(ParticleArgument("explosion_emitter"), AT_POSITION)
                return playSound(SoundArgument("entity.generic.explode"), PlaySoundMixer.BLOCK, mapMembersSelector(index), AT_POSITION)
            }

            for ((index, map) in References.MAPS.withIndex()) {
                execute {
                    ifCondition {
                        entity(self {
                            tag = "iron"
                            tag = map
                        })
                    }
                    run {
                        handleDrop(false, map, index)
                    }
                }
                execute {
                    ifCondition {
                        entity(self {
                            tag = "gold"
                            tag = map
                        })
                    }
                    run {
                        handleDrop(true, map, index)
                    }
                }
            }
        }

        // Add logic for picking up power-ups
        tick("collect_power_up") {
            for ((index, map) in References.MAPS.withIndex()) {
                execute {
                    // Only allow picking up after the map has started
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.STARTED, rangeOrInt(1))
                    }

                    // Allow picking up your map's drops
                    asTarget(allEntities {
                        tag = CrossfireTags.POWER_UP
                        tag = map
                    })
                    at(self())

                    // Determine if there is some entity that can pick it up
                    ifCondition {
                        entity(allPlayers {
                            // Find someone in this map that is not spectating
                            tag = "${CrossfireTags.SELECTED}-$map"
                            tag = !CrossfireTags.SPECTATING

                            // Find someone within 1.5 blocks of the power-up
                            distance = rangeEnd(1.5)

                            // Find someone with any of the three slots available still
                            nbt = !NbtCompound(
                                mapOf(
                                    "Inventory" to NbtList(
                                        listOf(
                                            NbtCompound(
                                                mapOf(
                                                    "Slot" to NbtByte(3)
                                                )
                                            ),
                                            NbtCompound(
                                                mapOf(
                                                    "Slot" to NbtByte(4)
                                                )
                                            ),
                                            NbtCompound(
                                                mapOf(
                                                    "Slot" to NbtByte(5)
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        })
                    }

                    run {
                        // Play effects to everyone in the same map
                        execute {
                            asTarget(mapMembersSelector(index))
                            run {
                                playSound(SoundArgument("block.note_block.chime"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 1.0, 0.5)
                                tellraw(
                                    self(),
                                    textComponent("A power-up was picked up, watch out!")
                                )
                            }
                        }

                        // Give the player the corresponding item
                        val items = mapOf(
                            "rapid_fire" to item("carrot_on_a_stick") {
                                customModelData(0)
                                itemName("Rapid Fire Power-up", Color.GOLD)
                            },
                            "multishot" to item("carrot_on_a_stick") {
                                customModelData(1)
                                itemName("Multishot Power-up", Color.LIGHT_PURPLE)
                            },
                            "swiftness" to item("potion") {
                                set(
                                    ComponentTypes.POTION_CONTENTS, NbtCompound(
                                        mapOf(
                                            "custom_color" to NbtInt(10806260),
                                            "custom_effects" to NbtList(
                                                listOf(
                                                    NbtCompound(
                                                        mapOf(
                                                            "id" to NbtString("minecraft:speed"),
                                                            "amplifier" to NbtInt(1),
                                                            "duration" to NbtInt(400)
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                                itemName("Swiftness II Potion", Color.AQUA)
                            },
                            "jump_boost" to item("potion") {
                                set(
                                    ComponentTypes.POTION_CONTENTS, NbtCompound(
                                        mapOf(
                                            "custom_color" to NbtInt(1309504),
                                            "custom_effects" to NbtList(
                                                listOf(
                                                    NbtCompound(
                                                        mapOf(
                                                            "id" to NbtString("minecraft:jump_boost"),
                                                            "amplifier" to NbtInt(4),
                                                            "duration" to NbtInt(400)
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                                itemName("Jump Boost V Potion", Color.GREEN)
                            },
                            "slow_falling" to item("potion") {
                                set(
                                    ComponentTypes.POTION_CONTENTS, NbtCompound(
                                        mapOf(
                                            "custom_color" to NbtInt(16777215),
                                            "custom_effects" to NbtList(
                                                listOf(
                                                    NbtCompound(
                                                        mapOf(
                                                            "id" to NbtString("minecraft:slow_falling"),
                                                            "amplifier" to NbtInt(0),
                                                            "duration" to NbtInt(400)
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                                itemName("Slow Falling I Potion", Color.GRAY)
                            }
                        )

                        // Reset success state from previous pickup attempt
                        scoreboard.players.set(self(), "success", 0)

                        // Go through all possible items and slots to pick up
                        for ((itemTag, item) in items) {
                            for (slot in 3..5) {
                                val targetPlayer = allPlayers(true) {
                                    // Find someone in this map that is not spectating
                                    tag = "${CrossfireTags.SELECTED}-$map"
                                    tag = !CrossfireTags.SPECTATING

                                    // Find someone within 1.5 blocks of the power-up
                                    distance = rangeEnd(1.5)

                                    // Find someone with a slot available still
                                    nbt = !NbtCompound(
                                        mapOf(
                                            "Inventory" to NbtList(
                                                listOf(
                                                    NbtCompound(
                                                        mapOf(
                                                            "Slot" to NbtByte(slot.toByte())
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                }

                                execute {
                                    ifCondition {
                                        entity(self {
                                            tag = itemTag

                                            // Only if nothing has yet been picked up!
                                            scores {
                                                score("success", 0)
                                            }
                                        })
                                    }
                                    ifCondition {
                                        entity(targetPlayer)
                                    }
                                    run {
                                        // Give them the item
                                        items {
                                            replace(
                                                targetPlayer,
                                                CONTAINER[slot],
                                                item
                                            )
                                        }

                                        // Play a pick-up sound to the player
                                        playSound(SoundArgument("entity.item.pickup"), PlaySoundMixer.PLAYER, targetPlayer, AT_POSITION, 1.0, 1.0)

                                        // Set success to 1 so no other pick-up triggers
                                        scoreboard.players.set(self(), "success", 1)
                                    }
                                }
                            }
                        }

                        // Destroy the drop
                        kill(self())
                    }
                }
            }
        }
    }
}