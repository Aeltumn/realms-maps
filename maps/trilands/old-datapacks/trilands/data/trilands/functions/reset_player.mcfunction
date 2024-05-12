clear @s[tag=!admin]

team leave @s
team join notready @s

tag @s remove joined
tag @s remove roundjoined
tag @s remove drowning
tag @s remove won
tag @s remove dead
tag @s remove player0
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
tag @s remove player0hit
tag @s remove player1hit
tag @s remove player2hit
tag @s remove player3hit
tag @s remove player4hit
tag @s remove player5hit
tag @s remove player6hit
tag @s remove player7hit
tag @s remove player8hit
tag @s remove player9hit
tag @s remove player10hit
tag @s remove challengefinish

effect clear @s
effect give @s minecraft:saturation 1000000 255 true
effect give @s minecraft:weakness 1000000 255 true
effect give @s minecraft:regeneration 1000000 255 true

tp @s[tag=!admin] -145.5 57 166.5 90 0

gamemode adventure @s[tag=!admin]

execute if score @s settings matches 1.. run scoreboard players set data settings 0

scoreboard players enable @s buy
scoreboard players set @s gold 0
scoreboard players set @s firstjoined 1
scoreboard players set @s killgold 0
scoreboard players set @s survivegold 0
scoreboard players set @s destroygold 0
scoreboard players set @s destroy 0
scoreboard players set @s crossbowreload -1
scoreboard players set @s tridentreload 0
scoreboard players set @s reloading 0
scoreboard players set @s destroyedblocks 0
scoreboard players set @s settings 0
scoreboard players set @s cooldown 0
scoreboard players set @s roundkills 0
scoreboard players set @s rounddestroyed 0
scoreboard players set @s outlived 0
scoreboard players set @s roundswon 0
scoreboard players set @s roundswongold 0
scoreboard players set @s tutorial -1

xp add @s -10000000

scoreboard players add @s Wins 0
scoreboard players add @s totalkills 0
scoreboard players add @s lifetimegold 0
scoreboard players add @s totalgold 0
scoreboard players add @s tridentsused 0
scoreboard players add @s gamesplayed 0
scoreboard players add @s totaldestroyed 0
scoreboard players add @s totaloutlived 0
scoreboard players add @s usedgrapling 0
scoreboard players add @s firstjoined 1
scoreboard players add @s c_progress 0
scoreboard players add @s challenge 0