package com.aeltumn.realms.crossfire.feature

import com.aeltumn.realms.common.AT_POSITION
import com.aeltumn.realms.common.Configurable
import com.aeltumn.realms.common.playSound
import com.aeltumn.realms.common.tick
import com.aeltumn.realms.crossfire.References
import com.aeltumn.realms.crossfire.component.CrossfireScoreboards
import com.aeltumn.realms.crossfire.component.CrossfireTags
import io.github.ayfri.kore.DataPack
import io.github.ayfri.kore.arguments.ARMOR
import io.github.ayfri.kore.arguments.chatcomponents.ChatComponents
import io.github.ayfri.kore.arguments.chatcomponents.clickEvent
import io.github.ayfri.kore.arguments.chatcomponents.events.ClickAction
import io.github.ayfri.kore.arguments.chatcomponents.events.HoverAction
import io.github.ayfri.kore.arguments.chatcomponents.events.runCommand
import io.github.ayfri.kore.arguments.chatcomponents.events.showText
import io.github.ayfri.kore.arguments.chatcomponents.hoverEvent
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.Color
import io.github.ayfri.kore.arguments.components.types.dyedColor
import io.github.ayfri.kore.arguments.components.types.enchantment
import io.github.ayfri.kore.arguments.components.types.enchantments
import io.github.ayfri.kore.arguments.components.types.unbreakable
import io.github.ayfri.kore.arguments.maths.vec3
import io.github.ayfri.kore.arguments.numbers.ranges.rangeOrInt
import io.github.ayfri.kore.arguments.numbers.relativePos
import io.github.ayfri.kore.arguments.scores.score
import io.github.ayfri.kore.arguments.selector.scores
import io.github.ayfri.kore.arguments.types.literals.allPlayers
import io.github.ayfri.kore.arguments.types.literals.self
import io.github.ayfri.kore.arguments.types.resources.EnchantmentArgument
import io.github.ayfri.kore.arguments.types.resources.item
import io.github.ayfri.kore.commands.TitleLocation
import io.github.ayfri.kore.commands.clear
import io.github.ayfri.kore.commands.execute.execute
import io.github.ayfri.kore.commands.function
import io.github.ayfri.kore.commands.items
import io.github.ayfri.kore.commands.scoreboard.scoreboard
import io.github.ayfri.kore.commands.tag
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.commands.tellraw
import io.github.ayfri.kore.commands.title
import io.github.ayfri.kore.commands.trigger
import io.github.ayfri.kore.functions.function

/** Handles the team joining system. */
public object TeamJoin : Configurable {

    /** Gives out armor to a player. */
    public const val GIVE_ARMOR: String = "give_armor"

    /** Clears the armor of a player. */
    public const val CLEAR_ARMOR: String = "clear_armor"

    override fun DataPack.configure() {
        tick("team_join") {
            for ((map, teams) in References.TEAMS) {
                for ((teamName) in teams) {
                    execute {
                        asTarget(
                            allPlayers {
                                team = !teamName
                                scores {
                                    score(CrossfireScoreboards.INTRO_COMPLETED) greaterThanOrEqualTo 1
                                }
                            }
                        )
                        at(self())
                        ifCondition {
                            block(vec3(0.relativePos, (-1).relativePos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("${teamName}_concrete"))
                        }

                        run {
                            title(self(), 10.0, 40.0, 10.0)
                            title(self(), TitleLocation.SUBTITLE, textComponent("Joined team: ").plus(textComponent(References.getDisplayNameForTeam(teamName), References.getColorForTeam(teamName)) { bold = true }))
                            title(self(), TitleLocation.TITLE, textComponent(References.getDisplayIconForTeam(teamName)))
                            tag(self()) {
                                add(CrossfireTags.JOINED)
                                add("${CrossfireTags.JOINED}-${map}")
                            }
                            playSound("minecraft:block.tripwire.attach", "player", self(), AT_POSITION, 2.0, 1.0)
                            teams {
                                join(teamName, self())
                            }
                            function(References.NAMESPACE, "give_armor")
                        }
                    }
                }
            }
        }

        tick("cant_join_team") {
            // Decrease just got spammed down from 15 to 0
            execute {
                asTarget(
                    allPlayers {
                        scores {
                            score(CrossfireScoreboards.JUST_GOT_SPAMMED, 1..15)
                        }
                    }
                )
                run {
                    scoreboard.players.remove(self(), CrossfireScoreboards.JUST_GOT_SPAMMED, 1)
                }
            }

            // Go through all teams and send the message
            for ((_, teams) in References.TEAMS) {
                for ((team) in teams) {
                    execute {
                        asTarget(
                            allPlayers {
                                tag = !team
                            }
                        )
                        at(self())
                        ifCondition {
                            block(vec3(0.relativePos, (-1).relativePos, 0.relativePos), io.github.ayfri.kore.arguments.types.resources.block("${team}_concrete"))
                        }

                        // Exclude players that already did the intro
                        unlessCondition {
                            score(self(), CrossfireScoreboards.INTRO_COMPLETED, rangeOrInt(1))
                        }

                        // Exclude players that just got spammed
                        unlessCondition {
                            score(self(), CrossfireScoreboards.MAP_SWITCH_COOLDOWN, rangeOrInt(1..15))
                        }

                        // Tell them to go do the intro
                        run {
                            scoreboard.players.set(self(), CrossfireScoreboards.JUST_GOT_SPAMMED, 15)
                            repeat(18) {
                                tellraw(self(), textComponent(""))
                            }
                            tellraw(
                                self(),
                                ChatComponents().apply {
                                    plus(textComponent("You can't join a team until you "))
                                    plus(textComponent("complete the tutorial", Color.AQUA) {
                                        hoverEvent(HoverAction.SHOW_TEXT) {
                                            showText {
                                                plus(textComponent("Click here to start the tutorial!"))
                                            }
                                        }
                                        clickEvent(ClickAction.RUN_COMMAND) {
                                            runCommand {
                                                trigger(CrossfireScoreboards.INTRO_START_TRIGGER) {
                                                    set(1)
                                                }
                                            }
                                        }
                                    })
                                    plus(textComponent("."))
                                }
                            )
                            tellraw(
                                self(),
                                ChatComponents().apply {
                                    plus(textComponent("Or "))
                                    plus(textComponent("click here", Color.RED) {
                                        hoverEvent(HoverAction.SHOW_TEXT) {
                                            showText {
                                                plus(textComponent("Click here to skip the tutorial."))
                                            }
                                        }
                                        clickEvent(ClickAction.RUN_COMMAND) {
                                            runCommand {
                                                trigger(CrossfireScoreboards.INTRO_SKIPPED_TRIGGER) {
                                                    set(1)
                                                }
                                            }
                                        }
                                    })
                                    plus(textComponent(" to skip the tutorial."))
                                }
                            )
                        }
                    }
                }
            }
        }

        function(GIVE_ARMOR) {
            for (teamName in References.TEAM_NAMES) {
                execute {
                    ifCondition {
                        entity(self {
                            team = teamName
                        })
                    }
                    run {
                        items {
                            replace(
                                self(),
                                ARMOR.CHEST,
                                item("leather_chestplate") {
                                    dyedColor(References.getArmorColorForTeam(teamName), showInTooltip = false)
                                    enchantments {
                                        enchantment(EnchantmentArgument("binding_curse"), 1)
                                        showInTooltip = false
                                    }
                                    unbreakable(false)
                                }
                            )
                            replace(
                                self(),
                                ARMOR.LEGS,
                                item("leather_leggings") {
                                    dyedColor(References.getArmorColorForTeam(teamName), showInTooltip = false)
                                    enchantments {
                                        enchantment(EnchantmentArgument("binding_curse"), 1)
                                        showInTooltip = false
                                    }
                                    unbreakable(false)
                                }
                            )
                            replace(
                                self(),
                                ARMOR.FEET,
                                item("leather_boots") {
                                    dyedColor(References.getArmorColorForTeam(teamName), showInTooltip = false)
                                    enchantments {
                                        enchantment(EnchantmentArgument("binding_curse"), 1)
                                        showInTooltip = false
                                    }
                                    unbreakable(false)
                                }
                            )
                        }
                    }
                }
            }

            // If you are not in any team we clear your items!
            execute {
                ifCondition {
                    entity(self {
                        for (teamName in References.TEAM_NAMES) {
                            team = "!${teamName}"
                        }
                    })
                }
                run {
                    function(References.NAMESPACE, CLEAR_ARMOR)
                }
            }
        }

        function(CLEAR_ARMOR) {
            clear(self(), item("leather_chestplate"))
            clear(self(), item("leather_leggings"))
            clear(self(), item("leather_boots"))
        }
    }
}