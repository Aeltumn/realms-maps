# Fix all scoreboard values
scoreboard players set @s intro -1
scoreboard players set @s deadtimer 0
scoreboard players add @s isreloading 0
scoreboard players add @s timer 0
scoreboard players add @s cooldown 0
scoreboard players add @s wins 0
scoreboard players add @s isreloading 0
scoreboard players add @s timer 0
scoreboard players add @s respawnshield 0

# Kick everyone out of spectator target
execute as @s[tag=spectating] run spectate

# Update round
execute if entity @s[scores={map=0}] run scoreboard players operation @s round = round0 round
execute if entity @s[scores={map=1}] run scoreboard players operation @s round = round1 round

# Remove tags
tag @s remove player1
tag @s remove player2
tag @s remove player3
tag @s remove player4
tag @s remove player5
tag @s remove player6
tag @s remove player7
tag @s remove player8
tag @s remove player9
tag @s remove player10
tag @s remove player11
tag @s remove selected
tag @s remove selected0
tag @s remove selected1
tag @s remove waterdead
tag @s remove died
tag @s remove spectating
tag @s remove spectateplayer1
tag @s remove spectateplayer2
tag @s remove spectateplayer3
tag @s remove spectateplayer4
tag @s remove spectateplayer5
tag @s remove spectateplayer6
tag @s remove spectateplayer7
tag @s remove spectateplayer8
tag @s remove spectateplayer9
tag @s remove spectateplayer10
tag @s remove spectateplayer11
tag @s remove hit
tag @s remove reloadcrossbow
tag @s remove joined0
tag @s remove joined1
tag @s remove shootrange
tag @s remove pregame

# We always give people crossbows, a bit dangerous, but alright.
tag @s add givecrossbow

# Reset roundkills
scoreboard players set @s roundKills 0

# Don't remove joined when going to postgame to avoid triggering spectator
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s remove joined
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s remove joined

# Give/take postgame
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tag @s add postgame
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tag @s add postgame
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s remove postgame
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s remove postgame

# Allow changing maps if not in post-game
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s add mapchanger
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s add mapchanger
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tag @s remove mapchanger
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tag @s remove mapchanger

# Remove from your team
team leave @s

# Clear your items
clear @s[tag=!admin] #crossfire:crossbow
clear @s[tag=!admin] minecraft:potion
clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:0}
clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:1}

# Teleport people back
gamemode adventure @s[tag=!admin]
function crossfire:give_armor
effect clear @s[tag=!admin]
team join lobby @s

# Teleport player
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tp @s[tag=!admin] 574.5 85 296.5 90 0
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tp @s[tag=!admin] 529 71 296 -90 0

execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tp @s[tag=!admin] 574.5 85 421.5 90 0
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tp @s[tag=!admin] 529 72 421 -90 0

# Reset exp
xp set @s 0 levels
xp set @s 0 points

# Quality of life!
effect give @s[tag=!admin] minecraft:instant_health 1 20 true
effect give @s[tag=!admin] minecraft:jump_boost 1000000 1 true
effect give @s[tag=!admin] minecraft:speed 1000000 0 true
effect give @s[tag=!admin] minecraft:weakness 1000000 255 true
effect give @s[tag=!admin] minecraft:resistance 1000000 255 true

# Update bossbars
bossbar set crossfire:timer0 players
bossbar set crossfire:postgame0 players
execute if score game0 bar matches 1 run bossbar set crossfire:timer0 players @a[scores={map=0}]
execute if score game0 bar matches 2 run bossbar set crossfire:postgame0 players @a[scores={map=0}]

bossbar set crossfire:timer1 players
bossbar set crossfire:postgame1 players
execute if score game1 bar matches 1 run bossbar set crossfire:timer1 players @a[scores={map=1}]
execute if score game1 bar matches 2 run bossbar set crossfire:postgame1 players @a[scores={map=1}]