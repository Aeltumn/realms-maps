package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfirePredicates
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import com.aeltumn.realms.crossfire.component.CrossfireTeams
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.CONTAINER
import io.github.ayfri.kore.arguments.ItemSlotType
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.entityComponent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.components.types.chargedProjectiles
import io.github.ayfri.kore.arguments.components.types.customModelData
import io.github.ayfri.kore.arguments.components.types.enchantmentGlintOverride
import io.github.ayfri.kore.arguments.components.types.enchantments
import io.github.ayfri.kore.arguments.components.types.itemName
import io.github.ayfri.kore.arguments.components.types.projectile
import io.github.ayfri.kore.arguments.components.types.unbreakable
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.ranges.rangeEnd
import io.github.ayfri.kore.arguments.numbers.ranges.rangeOrInt
import io.github.ayfri.kore.arguments.numbers.ticks
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allEntities
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.literal
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.ItemArgument
import io.github.ayfri.kore.arguments.types.resources.ParticleArgument
import io.github.ayfri.kore.arguments.types.resources.SoundArgument
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.arguments.types.resources.tagged.ItemTagArgument
import io.github.ayfri.kore.commands.Command
import io.github.ayfri.kore.commands.PlaySoundMixer
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.clear
import io.github.ayfri.kore.commands.command
import io.github.ayfri.kore.commands.data
import io.github.ayfri.kore.commands.effect
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.kill
import io.github.ayfri.kore.commands.particle.particle
import io.github.ayfri.kore.commands.playSound
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.summon
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.functions.Function
import io.github.ayfri.kore.functions.function
import io.github.ayfri.kore.functions.tick
import io.github.ayfri.kore.generated.Effects
import io.github.ayfri.kore.generated.Enchantments
import io.github.ayfri.kore.generated.EntityTypes
import net.benwoodworth.knbt.NbtByte
import net.benwoodworth.knbt.NbtCompound
import net.benwoodworth.knbt.NbtInt
import net.benwoodworth.knbt.NbtIntArray
import net.benwoodworth.knbt.NbtList
import net.benwoodworth.knbt.NbtString

/** Sets up the crossbow mechanic as well as inventory items in general. */
public object Crossbows : Configurable {

    private const val HIT_RANGE: Double = 3.75

    /** Gives out crossbows based on team color. */
    private fun Function.giveCrossbows(multishot: Boolean): Command {
        execute {
            ifCondition {
                entity(self {
                    team = "lime"
                })
            }
            run {
                giveCrossbowPerWins(1, 13, 5, 9, Color.GREEN, multishot)
            }
        }
        execute {
            ifCondition {
                entity(self {
                    team = "red"
                })
            }
            run {
                giveCrossbowPerWins(2, 14, 6, 10, Color.RED, multishot)
            }
        }
        execute {
            ifCondition {
                entity(self {
                    team = "yellow"
                })
            }
            run {
                giveCrossbowPerWins(4, 16, 8, 12, Color.YELLOW, multishot)
            }
        }
        execute {
            ifCondition {
                entity(self {
                    team = "light_blue"
                })
            }
            run {
                giveCrossbowPerWins(3, 15, 7, 11, Color.BLUE, multishot)
            }
        }
        execute {
            ifCondition {
                entity(self {
                    team = "orange"
                })
            }
            run {
                giveCrossbowPerWins(21, 23, 25, 27, Color.GOLD, multishot)
            }
        }
        execute {
            ifCondition {
                entity(self {
                    team = "magenta"
                })
            }
            run {
                giveCrossbowPerWins(22, 24, 26, 28, Color.LIGHT_PURPLE, multishot)
            }
        }

        return execute {
            ifCondition {
                entity(self {
                    team = CrossfireTeams.LOBBY_TEAM
                })
            }
            run {
                giveCrossbowPerWins(29, 30, 31, 32, Color.GRAY, multishot)
            }
        }
    }

    /** Gives a player a crossbow with models and [color] based on wins. */
    private fun Function.giveCrossbowPerWins(model1: Int, model2: Int, model3: Int, model4: Int, color: Color, multishot: Boolean): Command {
        execute {
            ifCondition {
                score(self(), CrossfireScoreboards.WINS) lessThanOrEqualTo 4
            }
            run {
                giveCrossbow(model1, color, multishot)
            }
        }
        execute {
            ifCondition {
                score(self(), CrossfireScoreboards.WINS, rangeOrInt(5..9))
            }
            run {
                giveCrossbow(model2, color, multishot)
            }
        }
        execute {
            ifCondition {
                score(self(), CrossfireScoreboards.WINS, rangeOrInt(10..14))
            }
            run {
                giveCrossbow(model3, color, multishot)
            }
        }
        return execute {
            ifCondition {
                score(self(), CrossfireScoreboards.WINS) greaterThanOrEqualTo 15
            }
            run {
                giveCrossbow(model4, color, multishot)
            }
        }
    }

    /** Gives a player a crossbow with [model] and [color]. */
    private fun Function.giveCrossbow(model: Int, color: Color, multishot: Boolean): Command =
        giveExactlyOne(
            item("crossbow") {
                itemName("Crossbow", color = color)
                enchantments {
                    levels += Enchantments.PIERCING to 10
                    if (multishot) {
                        levels += Enchantments.MULTISHOT to 1
                    }
                    showInTooltip = false
                }
                enchantmentGlintOverride(false)
                unbreakable(false)
                customModelData(model)
                chargedProjectiles {
                    projectile(item("arrow"))
                    if (multishot) {
                        projectile(item("arrow"))
                        projectile(item("arrow"))
                    }
                }
            },
            CONTAINER[1]
        )

    /** Ensures self() has exactly one of [item]. */
    private fun Function.giveExactlyOne(item: ItemArgument, slot: ItemSlotType): Command {
        execute {
            storeResult {
                score(
                    self(),
                    CrossfireScoreboards.ITEM_COUNT
                )
            }
            run {
                clear(
                    self(),
                    item = item,
                    maxCount = 0,
                )
            }
        }
        execute {
            ifCondition {
                score(self(), CrossfireScoreboards.ITEM_COUNT) greaterThanOrEqualTo 2
            }
            run {
                clear(
                    self(),
                    item = item,
                )
            }
        }
        return execute {
            unlessCondition {
                score(self(), CrossfireScoreboards.ITEM_COUNT) equalTo 1
            }
            run {
                items {
                    replace(self(), slot, item, count = 1)
                }
            }
        }
    }

    override fun DataPack.configure() {
        val emptyCrossbowItem = item("crossbow") {
            itemName("Empty Crossbow", color = Color.DARK_GRAY)
        }

        // Detect living crossbow shots
        tick("update_crossbow_bolts") {
            // Add age to arrows so we kill them if they exist for too long
            scoreboard.players.add(allEntities {
                type = EntityTypes.ARROW
            }, CrossfireScoreboards.AGE, 1)

            // Add particle to flying arrows
            execute {
                asTarget(allEntities {
                    type = EntityTypes.ARROW
                    tag = !CrossfireTags.DIED
                })
                at(self())
                run {
                    particle(ParticleArgument("firework", "minecraft"), AT_POSITION, vec3(0.0, 0.0, 0.0), 0.03, 2)
                }
            }

            // Add cloud particles when player is levitating upward after being 'sploded
            execute {
                asTarget(allPlayers {
                    tag = CrossfireTags.DIED
                    tag = !CrossfireTags.DIED_IN_WATER
                    tag = !CrossfireTags.SPECTATING
                })
                at(self())
                run {
                    particle(ParticleArgument("cloud", "minecraft"), AT_POSITION, vec3(0.1, 0.3, 0.1), 0.0, 3)
                }
            }

            // Trigger a hit when the age limit is reached or in the ground
            execute {
                asTarget(allEntities {
                    type = EntityTypes.ARROW
                    tag = CrossfireTags.INITIALIZED
                    tag = !CrossfireTags.DIED
                    scores {
                        score(CrossfireScoreboards.AGE) greaterThanOrEqualTo 19
                    }
                })
                run {
                    function(References.NAMESPACE, "arrow_hit")
                }
            }
            execute {
                asTarget(allEntities {
                    type = EntityTypes.ARROW
                    tag = CrossfireTags.INITIALIZED
                    tag = !CrossfireTags.DIED
                    nbt = NbtCompound(
                        mapOf(
                            "inGround" to NbtByte(1)
                        )
                    )
                })
                run {
                    function(References.NAMESPACE, "arrow_hit")
                }
            }

            // Trigger a hit on enemy teams
            for (teamName in References.TEAM_NAMES) {
                execute {
                    asTarget(allEntities {
                        type = EntityTypes.ARROW
                        tag = CrossfireTags.INITIALIZED
                        tag = !CrossfireTags.DIED
                        tag = teamName
                    })
                    at(self())
                    ifCondition {
                        entity(allPlayers {
                            team = !teamName
                            tag = CrossfireTags.SELECTED
                            tag = !CrossfireTags.DIED
                            tag = !CrossfireTags.SPECTATING
                            distance = rangeEnd(2.5)
                        })
                    }
                    run {
                        function(References.NAMESPACE, "arrow_hit")
                    }
                }
            }

            // Trigger a hit on supply crates
            execute {
                asTarget(allEntities {
                    type = EntityTypes.ARROW
                    tag = CrossfireTags.INITIALIZED
                    tag = !CrossfireTags.DIED
                })
                at(self())
                run {
                    // Merging this into the statement above caused some weird compilation error :/
                    execute {
                        ifCondition {
                            entity(allEntities {
                                tag = CrossfireTags.CRATE
                                distance = rangeEnd(2.5)
                            })
                        }
                        run {
                            function(References.NAMESPACE, "arrow_hit")
                        }
                    }
                }
            }
        }

        // Function for arrows hitting something
        function("arrow_hit", References.NAMESPACE) {
            // Prevent arrows from triggering multiple hits
            tag(self()) {
                add(CrossfireTags.DIED)
            }

            // Add the firework explosion colors
            for (teamName in (References.TEAM_NAMES + CrossfireTeams.LOBBY_TEAM)) {
                execute {
                    ifCondition {
                        entity(self {
                            tag = teamName
                        })
                    }
                    at(self())
                    run {
                        summonFirework(teamName)
                    }
                }
            }

            // Kill the arrow
            kill(self())

            // Determine if this arrow was a part of a game
            execute {
                ifCondition {
                    entity(self {
                        tag = !CrossfireTags.SHOOTING_RANGE
                    })
                }
                at(self())

                run {
                    // Remove hit from everyone so we can use it to determine the target
                    tag(allEntities {}) {
                        remove(CrossfireTags.HIT)
                    }

                    // Show kill screens
                    for (teamName in References.TEAM_NAMES) {
                        execute {
                            ifCondition {
                                entity(self {
                                    tag = teamName
                                })
                            }

                            // Find all players that might've been killed
                            asTarget(allPlayers {
                                distance = rangeEnd(HIT_RANGE)
                                team = !teamName
                                tag = !CrossfireTags.DIED
                                scores {
                                    score(CrossfireScoreboards.RESPAWN_SHIELD) lessThanOrEqualTo 0
                                }
                            })
                            run {
                                // Set the title times
                                title(self(), 20.ticks, 60.ticks, 0.ticks)

                                // Show them the title
                                title(self(), TitleLocation.SUBTITLE, textComponent("\uE004"))

                                val char = References.getKillIconForTeam(teamName)
                                title(
                                    self(),
                                    TitleLocation.TITLE,
                                    ChatComponents().apply {
                                        plus(textComponent(" $char "))
                                        plus(textComponent("Sploded!") {
                                            bold = true
                                            color = References.getColorForTeam(teamName)
                                        })
                                        plus(textComponent(" $char "))
                                    }
                                )

                                // Mark this player as hit
                                tag(self()) {
                                    add(CrossfireTags.HIT)
                                }
                            }
                        }
                    }

                    // Attempt to hit supply crates
                    scoreboard.players.set(literal("crate"), CrossfireScoreboards.SUCCESS, 0)
                    execute {
                        asTarget(allEntities {
                            tag = CrossfireTags.COPTER
                            tag = !CrossfireTags.LEFT_PAYLOAD
                            distance = rangeEnd(HIT_RANGE)
                        })
                        at(self())
                        run {
                            // Success! A crate got hit, we need to mark that down so we can send a message.
                            scoreboard.players.set(literal("crate"), CrossfireScoreboards.SUCCESS, 1)

                            // Mark this copter as wanting to drop its payload
                            tag(self()) {
                                add(CrossfireTags.READY_TO_DROP)
                            }

                            // Find the crate that belongs to this copter and mark it too
                            execute {
                                asTarget(allEntities {
                                    tag = CrossfireTags.CRATE
                                    tag = !CrossfireTags.READY_TO_DROP
                                    tag = !CrossfireTags.LEFT_PAYLOAD
                                    tag = !CrossfireTags.DROPPED
                                    distance = rangeEnd(1.5)
                                })
                                run {
                                    tag(self()) {
                                        add(CrossfireTags.READY_TO_DROP)
                                    }
                                }
                            }
                        }
                    }

                    // Add a message indicating a crate was hit
                    for ((mapIndex, map) in References.MAPS.withIndex()) {
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            execute {
                                // Only if a crate was hit
                                ifCondition {
                                    score(literal("crate"), CrossfireScoreboards.SUCCESS) equalTo 1
                                }

                                // Only if this entity exists
                                ifCondition {
                                    entity(self {
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                        tag = "${CrossfireTags.SELECTED}-$map"
                                    })
                                }

                                // Tell everyone about it!
                                run {
                                    tellraw(
                                        mapMembersSelector(mapIndex),
                                        ChatComponents().apply {
                                            // Find the player that corresponds to this arrow!
                                            plus(entityComponent(allPlayers {
                                                tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                                tag = "${CrossfireTags.SELECTED}-$map"
                                            }.selector.toString()))
                                            plus(textComponent(" has hit a crate! It's about to fall down!", Color.WHITE))
                                        }
                                    )
                                }
                            }
                        }
                    }
                    scoreboard.players.reset(literal("crate"), CrossfireScoreboards.SUCCESS)

                    // Add messages for teamkilling
                    for (teamName in References.TEAM_NAMES) {
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            execute {
                                // If you are a player on this team
                                ifCondition {
                                    entity(self {
                                        tag = teamName
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                    })
                                }

                                // If you hit someone on this team that's not you
                                ifCondition {
                                    entity(allPlayers {
                                        distance = rangeEnd(HIT_RANGE)
                                        team = teamName
                                        tag = !"${CrossfireTags.PLAYER}-$playerIndex"
                                    })
                                }

                                run {
                                    // Tell you off about team killing!
                                    title(
                                        allPlayers {
                                            tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                        },
                                        TitleLocation.ACTIONBAR,
                                        textComponent("Don't attack your teammates!", Color.RED)
                                    )
                                }
                            }
                        }
                    }

                    // Add messages for respawn shield hitting
                    for (teamName in References.TEAM_NAMES) {
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            execute {
                                // If you are a player on this team
                                ifCondition {
                                    entity(self {
                                        tag = teamName
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                    })
                                }

                                // If you hit someone on another team with a shield
                                ifCondition {
                                    entity(allPlayers {
                                        distance = rangeEnd(HIT_RANGE)
                                        team = !teamName

                                        scores {
                                            score(CrossfireScoreboards.RESPAWN_SHIELD) greaterThan 0
                                        }
                                    })
                                }

                                run {
                                    // Tell you off about team killing!
                                    title(
                                        allPlayers {
                                            tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                        },
                                        TitleLocation.ACTIONBAR,
                                        textComponent("You've hit a player that was still respawning!", Color.YELLOW)
                                    )
                                }
                            }
                        }
                    }

                    // Add the kill effect
                    for (playerIndex in 0 until References.PLAYER_COUNT) {
                        val target = allPlayers {
                            tag = "${CrossfireTags.PLAYER}-$playerIndex"
                        }

                        execute {
                            ifCondition {
                                entity(self {
                                    tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                })
                            }
                            asTarget(allPlayers {
                                tag = CrossfireTags.HIT
                            })
                            run {
                                // Add the kill title
                                title(target, 10.ticks, 30.ticks, 10.ticks)
                                title(target, TitleLocation.SUBTITLE, ChatComponents().apply {
                                    plus(textComponent("You've killed: "))
                                    plus(entityComponent(self().selector.toString()))
                                })
                                title(target, TitleLocation.TITLE, textComponent(""))

                                // Make that player spectate the killer
                                tag(self()) {
                                    add("${CrossfireTags.SPECTATE_PLAYER}-$playerIndex")
                                }

                                // Give out a kill to the killer
                                scoreboard.players.add(target, CrossfireScoreboards.LIFETIME_KILLS, 1)
                                scoreboard.players.add(target, CrossfireScoreboards.ROUND_KILLS, 1)
                            }
                        }


                        // Add a ding if someone got killed
                        execute {
                            // If playerX shot this firework
                            ifCondition {
                                entity(self {
                                    tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                })
                            }

                            // If someone got hit
                            ifCondition {
                                entity(
                                    allEntities {
                                        tag = CrossfireTags.HIT
                                    }
                                )
                            }

                            // At the target
                            asTarget(target)
                            at(self())

                            // Play the noise to playerX
                            run {
                                playSound(SoundArgument("block.note_block.bell"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 0.5, 0.0)
                            }
                        }

                        // Add a kill to the shooter's team
                        for (teamName in References.TEAM_NAMES) {
                            execute {
                                ifCondition {
                                    entity(self {
                                        tag = teamName
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                    })
                                }
                                asTarget(allPlayers {
                                    tag = CrossfireTags.HIT
                                })
                                run {
                                    scoreboard.players.add(literal(References.getDisplayNameForTeam(teamName)), CrossfireScoreboards.TEAM_KILLS, 1)
                                }
                            }
                        }
                    }

                    // Add the chat message for the kill
                    for ((mapIndex, map) in References.MAPS.withIndex()) {
                        for (playerIndex in 0 until References.PLAYER_COUNT) {
                            execute {
                                ifCondition {
                                    entity(self {
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                        tag = "${CrossfireTags.SELECTED}-$map"
                                    })
                                }
                                asTarget(allPlayers {
                                    tag = CrossfireTags.HIT
                                })
                                run {
                                    val target = allPlayers {
                                        tag = "${CrossfireTags.PLAYER}-$playerIndex"
                                    }

                                    tellraw(
                                        mapMembersSelector(mapIndex),
                                        ChatComponents().apply {
                                            plus(entityComponent(self().selector.toString()))
                                            plus(textComponent(" was sploded by ", Color.WHITE))
                                            plus(entityComponent(target.selector.toString()))
                                        }
                                    )
                                }
                            }
                        }
                    }

                    // Add the hit effect itself for the hit player
                    execute {
                        asTarget(allPlayers {
                            tag = CrossfireTags.HIT
                        })
                        run {
                            function(References.NAMESPACE, "player_hit")
                        }
                    }
                }
            }
        }

        // Detect shooting crossbow
        tick("detect_crossbow_shot") {
            execute {
                asTarget(allPlayers {
                    scores {
                        score(CrossfireScoreboards.ITEM_USE_CROSSBOW) greaterThanOrEqualTo 1
                    }
                })

                run {
                    // Reset their item use score
                    scoreboard.players.set(self(), CrossfireScoreboards.ITEM_USE_CROSSBOW, 0)

                    // Remove tags marking the players having the crossbow loaded
                    tag(self()) {
                        remove(CrossfireTags.HAS_CROSSBOW_LOADED)
                        remove(CrossfireTags.HAS_MULTISHOT_LOADED)
                    }

                    // Give proper player shooter tags
                    repeat(3) {
                        execute {
                            at(self())
                            run {
                                // Run this only on one entity!
                                data(allEntities(true) {
                                    type = EntityTypes.ARROW
                                    distance = rangeEnd(4)

                                    // This avoids selecting the same arrow multiple times
                                    tag = !CrossfireTags.GIVE_CROSSBOW
                                }) {
                                    // Copy the Tags over to the arrow
                                    modify("Tags") {
                                        set(self(), "Tags")
                                    }
                                }
                            }
                        }
                    }

                    // Make all nearby arrows not able to be picked up (we don't need to keep the self context here)
                    execute {
                        at(self())
                        asTarget(allEntities {
                            type = EntityTypes.ARROW
                            distance = rangeEnd(4)
                        })
                        run {
                            data(self()) {
                                modify("pickup") {
                                    set(NbtByte(0))
                                }
                            }
                        }
                    }

                    // Give the entities a tag based on the team of the shooter
                    for (teamName in (References.TEAM_NAMES + CrossfireTeams.LOBBY_TEAM)) {
                        execute {
                            ifCondition {
                                entity(self {
                                    team = teamName
                                })
                            }
                            at(self())
                            run {
                                tag(allEntities {
                                    // Find all nearby arrow entities that do not yet have any team
                                    type = EntityTypes.ARROW
                                    distance = rangeEnd(4)

                                    for (otherTeamName in (References.TEAM_NAMES + CrossfireTeams.LOBBY_TEAM)) {
                                        tag = !otherTeamName
                                    }
                                }) {
                                    add(teamName)
                                    add(CrossfireTags.INITIALIZED)
                                }
                            }
                        }
                    }

                    // Play bow shooting sounds
                    playSound(SoundArgument("item.trident.hit_ground", "minecraft"), PlaySoundMixer.AMBIENT, allPlayers(), AT_POSITION, 10.0, 0.0)
                    playSound(SoundArgument("entity.firework_rocket.launch", "minecraft"), PlaySoundMixer.AMBIENT, allPlayers(), AT_POSITION, 10.0, 1.0)
                }
            }
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
            clear(allPlayers(), ItemArgument("arrow", "minecraft"))
            clear(allPlayers(), ItemArgument("glass_bottle", "minecraft"))

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
                        }
                    )
                }
                run {
                    // Remove the give crossbow tag
                    tag(self()) {
                        remove(CrossfireTags.GIVE_CROSSBOW)
                    }

                    // Remove any actual crossbows
                    clear(self(), item("crossbow"))
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
                            tag = CrossfireTags.GIVE_CROSSBOW
                        }
                    )
                }
                run {
                    // Remove the reload crossbow tag, we run the cancel
                    // function elsewhere
                    tag(self()) {
                        remove(CrossfireTags.RELOAD_CROSSBOW)
                    }
                }
            }

            // Give out the map changer item properly
            val leaveItem = item("carrot_on_a_stick") {
                customModelData(4)
                itemName("Leave Game", Color.RED)
            }
            for ((index, map) in References.MAPS.withIndex()) {
                val switchItem = when (map) {
                    "duel" -> item("carrot_on_a_stick") {
                        customModelData(3)
                        itemName("Go to the Party Map", Color.DARK_GREEN)
                    }

                    "party" -> item("carrot_on_a_stick") {
                        customModelData(2)
                        itemName("Go to the Duel Map", Color.DARK_AQUA)
                    }

                    else -> throw IllegalArgumentException("Invalid map name $map")
                }

                execute {
                    // If this map has not started
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.STARTED, rangeOrInt(0))
                    }

                    // On all players in this map
                    asTarget(allPlayers {
                        scores {
                            score(CrossfireScoreboards.TARGET_MAP_INDEX, index)
                        }
                    })

                    // Give them the map changer item (once)
                    run {
                        giveExactlyOne(switchItem, CONTAINER[8])
                    }
                }
                execute {
                    // If this map has started
                    unlessCondition {
                        score(literal(map), CrossfireScoreboards.STARTED, rangeOrInt(0))
                    }

                    // On all players in this map that are spectating
                    asTarget(allPlayers {
                        tag = CrossfireTags.SPECTATING
                        scores {
                            score(CrossfireScoreboards.TARGET_MAP_INDEX, index)
                        }
                    })

                    // Give them the map changer item (once)
                    run {
                        giveExactlyOne(switchItem, CONTAINER[8])
                    }
                }
                execute {
                    // If this map has started
                    unlessCondition {
                        score(literal(map), CrossfireScoreboards.STARTED, rangeOrInt(0))
                    }

                    // If we're in the post-game
                    ifCondition {
                        score(literal(map), CrossfireScoreboards.GAME_STATE, rangeOrInt(3))
                    }

                    // On all players in this map
                    asTarget(allPlayers {
                        scores {
                            score(CrossfireScoreboards.TARGET_MAP_INDEX, index)
                        }
                    })

                    // Give them the map changer item (once)
                    run {
                        giveExactlyOne(switchItem, CONTAINER[8])
                    }
                }

                // If the game has started give out the quit item
                execute {
                    // Let you leave if the map has started
                    unlessCondition {
                        score(literal(map), CrossfireScoreboards.STARTED, rangeOrInt(0))
                    }

                    // Don't let you leave anymore during game state 3 (post-game)
                    unlessCondition {
                        score(literal(map), CrossfireScoreboards.GAME_STATE, rangeOrInt(3))
                    }

                    // On all players in this map that are not spectating
                    asTarget(allPlayers {
                        tag = !CrossfireTags.SPECTATING
                        scores {
                            score(CrossfireScoreboards.TARGET_MAP_INDEX, index)
                        }
                    })

                    // Give them the leave item
                    run {
                        giveExactlyOne(leaveItem, CONTAINER[8])
                    }
                }
            }

            // Update the player's reloading state
            execute {
                // Find all players that may reload which are holding a crossbow
                asTarget(allPlayers {
                    tag = CrossfireTags.RELOAD_CROSSBOW
                    tag = !CrossfireTags.HAS_CROSSBOW_LOADED
                    nbt = NbtCompound(
                        mapOf(
                            "SelectedItem" to NbtCompound(
                                mapOf(
                                    "id" to NbtString("minecraft:crossbow")
                                )
                            )
                        )
                    )

                    scores {
                        // Don't start reloading if already reloading
                        score(CrossfireScoreboards.IS_RELOADING, 0)

                        // Don't start reloading if the respawn shield is still above 3
                        score(CrossfireScoreboards.RESPAWN_SHIELD, 0..60)
                    }
                })

                // Start reloading
                run {
                    scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 1)
                    scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)
                }
            }

            // Stop reloading if anything becomes untrue
            execute {
                // Find all reloading players
                asTarget(allPlayers {
                    scores {
                        score(CrossfireScoreboards.IS_RELOADING, 1)
                    }
                })

                // Allow you to keep reloading if everything matches
                unlessCondition {
                    entity(self {
                        tag = CrossfireTags.RELOAD_CROSSBOW
                        tag = !CrossfireTags.HAS_CROSSBOW_LOADED
                        nbt = NbtCompound(
                            mapOf(
                                "SelectedItem" to NbtCompound(
                                    mapOf(
                                        "id" to NbtString("minecraft:crossbow")
                                    )
                                )
                            )
                        )
                        scores {
                            score(CrossfireScoreboards.RESPAWN_SHIELD, 0..60)
                        }
                    })
                }

                // Stop reloading
                run {
                    scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
                    scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)
                }
            }

            // Increment reload timers
            scoreboard.players.add(
                allPlayers {
                    scores {
                        score(CrossfireScoreboards.IS_RELOADING, 1)
                    }
                },
                CrossfireScoreboards.RELOAD_TIMER,
                1
            )

            // Increase reload timer even more if you have rapid fire
            scoreboard.players.add(
                allPlayers {
                    scores {
                        score(CrossfireScoreboards.IS_RELOADING, 1)
                    }
                    predicate = CrossfirePredicates.HAS_RAPID_FIRE
                },
                CrossfireScoreboards.RELOAD_TIMER,
                3
            )

            // Give empty crossbows to all players that aren't reloading
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        tag = !CrossfireTags.HAS_CROSSBOW_LOADED
                    }
                )

                // Don't give them an empty crossbow when they are reloading
                unlessCondition {
                    score(self(), CrossfireScoreboards.IS_RELOADING) greaterThan 1
                }

                run {
                    giveExactlyOne(emptyCrossbowItem, CONTAINER[1])
                }
            }

            // Give out various types of crossbows based on reload progress
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        scores {
                            score(CrossfireScoreboards.IS_RELOADING, 1)
                            score(CrossfireScoreboards.RELOAD_TIMER, 0..10)
                        }
                    }
                )

                run {
                    giveExactlyOne(
                        item("crossbow") {
                            itemName("Reloading Crossbow", color = Color.DARK_GRAY)
                            customModelData(17)
                        },
                        CONTAINER[1]
                    )
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        scores {
                            score(CrossfireScoreboards.IS_RELOADING, 1)
                            score(CrossfireScoreboards.RELOAD_TIMER, 11..20)
                        }
                    }
                )

                run {
                    giveExactlyOne(
                        item("crossbow") {
                            itemName("Reloading Crossbow.", color = Color.DARK_GRAY)
                            customModelData(18)
                        },
                        CONTAINER[1]
                    )
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        scores {
                            score(CrossfireScoreboards.IS_RELOADING, 1)
                            score(CrossfireScoreboards.RELOAD_TIMER, 21..30)
                        }
                    }
                )

                run {
                    giveExactlyOne(
                        item("crossbow") {
                            itemName("Reloading Crossbow..", color = Color.DARK_GRAY)
                            customModelData(19)
                        },
                        CONTAINER[1]
                    )
                }
            }
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        scores {
                            score(CrossfireScoreboards.IS_RELOADING, 1)
                            score(CrossfireScoreboards.RELOAD_TIMER, 31..40)
                        }
                    }
                )

                run {
                    giveExactlyOne(
                        item("crossbow") {
                            itemName("Reloading Crossbow...", color = Color.DARK_GRAY)
                            customModelData(20)
                        },
                        CONTAINER[1]
                    )
                }
            }

            // Finish the reload when the player reaches 40
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        scores {
                            score(CrossfireScoreboards.IS_RELOADING, 1)
                        }
                    }
                )
                ifCondition {
                    score(self(), CrossfireScoreboards.RELOAD_TIMER) greaterThanOrEqualTo 40
                }

                run {
                    // Play a sound effect
                    playSound(SoundArgument("item.bottle.fill_dragonbreath", "minecraft"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 0.4, 1.0)

                    // Update the crossbow
                    function("update_crossbow_state")
                }
            }

            // Update the crossbow state if the player obtained multi-shot
            execute {
                asTarget(
                    allEntities {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        tag = CrossfireTags.HAS_CROSSBOW_LOADED
                        tag = !CrossfireTags.HAS_MULTISHOT_LOADED
                        predicate = CrossfirePredicates.HAS_MULTISHOT
                    }
                )

                run {
                    // Update the crossbow state to include multi-shot
                    function("update_crossbow_state")
                }
            }

            // We don't remove a charged multi-shot if you lose the effect!

            // If you have no crossbow at all we take away the loaded tag
            execute {
                asTarget(
                    allPlayers {
                        tag = CrossfireTags.GIVE_CROSSBOW
                        tag = CrossfireTags.HAS_CROSSBOW_LOADED
                    }
                )

                run {
                    execute {
                        storeResult {
                            score(
                                self(),
                                CrossfireScoreboards.ITEM_COUNT
                            )
                        }
                        run {
                            clear(
                                self(),
                                item = ItemArgument("crossbow", "minecraft"),
                                maxCount = 0,
                            )
                        }
                    }
                    execute {
                        ifCondition {
                            score(self(), CrossfireScoreboards.ITEM_COUNT) greaterThanOrEqualTo 2
                        }
                        run {
                            clear(
                                self(),
                                item = ItemArgument("crossbow", "minecraft"),
                            )
                        }
                    }
                    execute {
                        unlessCondition {
                            score(self(), CrossfireScoreboards.ITEM_COUNT) equalTo 1
                        }
                        run {
                            // Take away the loaded tag which will start the reload again
                            tag(self()) {
                                remove(CrossfireTags.HAS_CROSSBOW_LOADED)
                                remove(CrossfireTags.HAS_MULTISHOT_LOADED)
                            }
                        }
                    }
                }
            }
        }

        // Update the current crossbow item state
        function("update_crossbow_state") {
            // Reset the reloading
            scoreboard.players.set(self(), CrossfireScoreboards.IS_RELOADING, 0)
            scoreboard.players.set(self(), CrossfireScoreboards.RELOAD_TIMER, 0)

            // Mark the crossbow as loaded
            tag(self()) {
                add(CrossfireTags.HAS_CROSSBOW_LOADED)
            }

            // Change the given item based on whether you have multi-shot
            execute {
                ifCondition {
                    entity(self {
                        predicate = CrossfirePredicates.HAS_MULTISHOT
                    })
                }

                run {
                    // Add the multi-shot tag
                    tag(self()) {
                        add(CrossfireTags.HAS_MULTISHOT_LOADED)
                    }

                    // Give the crossbow
                    giveCrossbows(true)
                }
            }
            execute {
                unlessCondition {
                    entity(self {
                        predicate = CrossfirePredicates.HAS_MULTISHOT
                    })
                }

                run {
                    // Remove the multi-shot tag
                    tag(self()) {
                        remove(CrossfireTags.HAS_MULTISHOT_LOADED)
                    }

                    // Give the crossbow
                    giveCrossbows(false)
                }
            }
        }

        // Trigger player hit effect
        function("player_hit", References.NAMESPACE) {
            // Mark the player as dead
            tag(self()) {
                add(CrossfireTags.DIED)
                remove(CrossfireTags.HIT)
            }

            // Take away their crossbow
            clear(self(), ItemArgument("crossbow", "minecraft"))

            // Give them levitation so they float up
            effect(self()) {
                give(Effects.LEVITATION, 1, 40, true)
            }

            // Play a trident sound
            playSound(SoundArgument("item.trident.riptide_3"), PlaySoundMixer.PLAYER, self(), AT_POSITION, 1.0, 1.0)
        }
    }
}

/** Summons a firework. */
public fun Function.summonFirework(teamName: String, type: String = "small_ball", lifeTime: Int = 0): Command {
    return summon(EntityTypes.FIREWORK_ROCKET, AT_POSITION) {
        put("Tags", NbtList(listOf(NbtString("custom"))))
        put("LifeTime", NbtInt(lifeTime))
        put(
            "FireworksItem", NbtCompound(
                mapOf(
                    "id" to NbtString("minecraft:firework_rocket"),
                    "count" to NbtInt(1),
                    "components" to NbtCompound(
                        mapOf(
                            "minecraft:fireworks" to NbtCompound(
                                mapOf(
                                    "explosions" to NbtList(
                                        listOf(
                                            NbtCompound(
                                                mapOf(
                                                    "shape" to NbtString(type),
                                                    "colors" to NbtIntArray(
                                                        intArrayOf(
                                                            when (teamName) {
                                                                "red" -> 11743532
                                                                "yellow" -> 14602026
                                                                "lime" -> 4312372
                                                                "light_blue" -> 6719955
                                                                "orange" -> 15435844
                                                                "magenta" -> 12801229
                                                                "lobby" -> 11250603
                                                                else -> throw IllegalArgumentException("No firework color known for team $teamName")
                                                            }
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    }
}