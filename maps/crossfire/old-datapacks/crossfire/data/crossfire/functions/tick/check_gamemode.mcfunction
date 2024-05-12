# Put into spectating only if your map has started
execute if score started0 started matches 1 as @a[tag=!spectating,tag=!joined,tag=!admin,scores={map=0}] run tag @s add spectating
execute if score started1 started matches 1 as @a[tag=!spectating,tag=!joined,tag=!admin,scores={map=1}] run tag @s add spectating

# Give potion effects if spectating
effect give @a[tag=spectating] minecraft:levitation 1000000 255 true
effect give @a[tag=spectating] minecraft:invisibility 1000000 255 true

# Remove the player spectate tag if that player is now also spectating
execute as @a[tag=spectateplayer1] unless entity @a[tag=player1,tag=!spectating] run tag @s remove spectateplayer1
execute as @a[tag=spectateplayer2] unless entity @a[tag=player2,tag=!spectating] run tag @s remove spectateplayer2
execute as @a[tag=spectateplayer3] unless entity @a[tag=player3,tag=!spectating] run tag @s remove spectateplayer3
execute as @a[tag=spectateplayer4] unless entity @a[tag=player4,tag=!spectating] run tag @s remove spectateplayer4
execute as @a[tag=spectateplayer5] unless entity @a[tag=player5,tag=!spectating] run tag @s remove spectateplayer5
execute as @a[tag=spectateplayer6] unless entity @a[tag=player6,tag=!spectating] run tag @s remove spectateplayer6
execute as @a[tag=spectateplayer7] unless entity @a[tag=player7,tag=!spectating] run tag @s remove spectateplayer7
execute as @a[tag=spectateplayer8] unless entity @a[tag=player8,tag=!spectating] run tag @s remove spectateplayer8
execute as @a[tag=spectateplayer9] unless entity @a[tag=player9,tag=!spectating] run tag @s remove spectateplayer9
execute as @a[tag=spectateplayer10] unless entity @a[tag=player10,tag=!spectating] run tag @s remove spectateplayer10
execute as @a[tag=spectateplayer11] unless entity @a[tag=player11,tag=!spectating] run tag @s remove spectateplayer11

# Give spectatoradventure if we have no specateplayer
execute as @a unless entity @s[tag=!spectateplayer1,tag=!spectateplayer2,tag=!spectateplayer3,tag=!spectateplayer4,tag=!spectateplayer5,tag=!spectateplayer6,tag=!spectateplayer7,tag=!spectateplayer8,tag=!spectateplayer9,tag=!spectateplayer10,tag=!spectateplayer11] run tag @s remove spectatoradventure
execute as @a if entity @s[tag=!spectateplayer1,tag=!spectateplayer2,tag=!spectateplayer3,tag=!spectateplayer4,tag=!spectateplayer5,tag=!spectateplayer6,tag=!spectateplayer7,tag=!spectateplayer8,tag=!spectateplayer9,tag=!spectateplayer10,tag=!spectateplayer11] run tag @s add spectatoradventure

# Set into the proper gamemode
execute as @a[tag=spectatoradventure,tag=spectating,tag=!admin] unless score @s intro matches 0.. run gamemode adventure
execute as @a[tag=!spectatoradventure,tag=spectating,tag=!admin] run gamemode spectator
execute as @a[scores={intro=0..}] run gamemode spectator

# Put into spectate camera's for intro
execute as @a[scores={intro=0..18}] run spectate @e[tag=camera0,limit=1] @s
execute as @a[scores={intro=19..31}] run spectate @e[tag=camera1,limit=1] @s
execute as @a[scores={intro=32..}] run spectate @e[tag=camera2,limit=1] @s

# Actually make player spectate if applicable
execute as @a[tag=spectateplayer1,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player1,tag=!spectating] @s
execute as @a[tag=spectateplayer2,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player2,tag=!spectating] @s
execute as @a[tag=spectateplayer3,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player3,tag=!spectating] @s
execute as @a[tag=spectateplayer4,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player4,tag=!spectating] @s
execute as @a[tag=spectateplayer5,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player5,tag=!spectating] @s
execute as @a[tag=spectateplayer6,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player6,tag=!spectating] @s
execute as @a[tag=spectateplayer7,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player7,tag=!spectating] @s
execute as @a[tag=spectateplayer8,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player8,tag=!spectating] @s
execute as @a[tag=spectateplayer9,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player9,tag=!spectating] @s
execute as @a[tag=spectateplayer10,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player10,tag=!spectating] @s
execute as @a[tag=spectateplayer11,tag=spectating,gamemode=spectator] run spectate @e[limit=1,tag=player11,tag=!spectating] @s

# If nothing else, we do the spectator cam
# 1 - duel, 0 - party
execute as @a[tag=spectatoradventure,gamemode=adventure,tag=spectating,scores={map=0}] at @e[tag=flightpath0] run tp @s ^ ^ ^18 facing entity @e[tag=spectatetarget0,limit=1]
execute as @a[tag=spectatoradventure,gamemode=adventure,tag=spectating,scores={map=1}] at @e[tag=flightpath1] run tp @s ^ ^ ^18 facing entity @e[tag=spectatetarget1,limit=1]
