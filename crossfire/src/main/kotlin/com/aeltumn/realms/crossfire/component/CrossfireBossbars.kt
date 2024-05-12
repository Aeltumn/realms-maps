package com.aeltumn.realms.crossfire.component

import com.aeltumn.realms.crossfire.References
import io.github.ayfri.kore.arguments.chatcomponents.textComponent
import io.github.ayfri.kore.arguments.colors.BossBarColor
import io.github.ayfri.kore.commands.bossBar
import io.github.ayfri.kore.functions.Function

/** Manages crossfire's boss bars. */
public object CrossfireBossbars {

    /** Returns the name of the timer boss bar for [map]. */
    public fun getTimer(map: String): String = "timer_$map"

    /** Returns the name of the post game boss bar for [map]. */
    public fun getPostGame(map: String): String = "post_game_$map"

    /** Sets up the boss bars. */
    public fun setup(function: Function) {
        function.apply {
            for (map in References.MAPS) {
                bossBar(getPostGame(map), References.NAMESPACE) {
                    setColor(BossBarColor.BLUE)
                    setMax(25)
                    add(textComponent(""))
                }
                bossBar(getTimer(map), References.NAMESPACE) {
                    setColor(BossBarColor.YELLOW)
                    setMax(300)
                    add(textComponent(""))
                }
            }
        }
    }
}