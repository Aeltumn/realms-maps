package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.common.Setuppable
import com.aeltumn.realms.crossfire.References
import io.github.ayfri.kore.arguments.colors.FormattingColor
import io.github.ayfri.kore.commands.CollisionRule
import io.github.ayfri.kore.commands.Visibility
import io.github.ayfri.kore.commands.teams
import io.github.ayfri.kore.functions.Function

/** Manages crossfire's teams. */
public object CrossfireTeams : Setuppable {

    /** The name of the team used in the lobby area. */
    public const val LOBBY_TEAM: String = "lobby"

    override fun Function.setup() {
        teams {
            for (map in References.TEAMS.values) {
                for ((team, color) in map) {
                    add(team)
                    modify(team) {
                        collisionRule(CollisionRule.NEVER)
                        seeFriendlyInvisibles(false)
                        nametagVisibility(Visibility.NEVER)
                        color(color)
                    }
                }
            }

            add(LOBBY_TEAM)
            modify(LOBBY_TEAM) {
                collisionRule(CollisionRule.NEVER)
                seeFriendlyInvisibles(false)
                nametagVisibility(Visibility.ALWAYS)
                color(FormattingColor.GRAY)
            }
        }
    }
}