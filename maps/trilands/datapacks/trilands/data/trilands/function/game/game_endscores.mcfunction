team leave @a[tag=!admin]
scoreboard players set data roundtimer -1
scoreboard players set data gracetime -1
scoreboard players set data newround -1

execute as @a[tag=joined] if score @s challenge matches 10 run scoreboard players add @s c_progress 1

bossbar set minecraft:gracetimer players
bossbar set minecraft:newround players
bossbar set minecraft:round players

title @a actionbar {"text":" "}
title @a title {"text":" "}
title @a subtitle {"text":" "}

scoreboard players set player0 gold 0
scoreboard players set player1 gold 0
scoreboard players set player2 gold 0
scoreboard players set player3 gold 0
scoreboard players set player4 gold 0
scoreboard players set player5 gold 0
scoreboard players set player6 gold 0
scoreboard players set player7 gold 0
scoreboard players set player8 gold 0
scoreboard players set player9 gold 0
scoreboard players set player10 gold 0

execute as @a[tag=joined] run scoreboard players operation @s gold += @s killgold
execute as @a[tag=joined] run scoreboard players operation @s gold += @s survivegold
execute as @a[tag=joined] run scoreboard players operation @s gold += @s destroygold
execute as @a[tag=joined] run scoreboard players operation @s gold += @s roundswongold

execute as @a[tag=joined] run scoreboard players operation @s totalgold += @s gold
execute as @a[tag=joined] run scoreboard players operation @s lifetimegold += @s gold

scoreboard players operation player0 gold = @a[tag=player0] gold
scoreboard players operation player1 gold = @a[tag=player1] gold
scoreboard players operation player2 gold = @a[tag=player2] gold
scoreboard players operation player3 gold = @a[tag=player3] gold
scoreboard players operation player4 gold = @a[tag=player4] gold
scoreboard players operation player5 gold = @a[tag=player5] gold
scoreboard players operation player6 gold = @a[tag=player6] gold
scoreboard players operation player7 gold = @a[tag=player7] gold
scoreboard players operation player8 gold = @a[tag=player8] gold
scoreboard players operation player9 gold = @a[tag=player9] gold
scoreboard players operation player10 gold = @a[tag=player10] gold


execute if score player0 gold > player1 gold if score player0 gold > player2 gold if score player0 gold > player3 gold if score player0 gold > player4 gold if score player0 gold > player5 gold if score player0 gold > player6 gold if score player0 gold > player7 gold if score player0 gold > player8 gold if score player0 gold > player9 gold if score player0 gold > player10 gold as @a[tag=player0] run function trilands:game/game_win

execute if score player1 gold > player0 gold if score player1 gold > player2 gold if score player1 gold > player3 gold if score player1 gold > player4 gold if score player1 gold > player5 gold if score player1 gold > player6 gold if score player1 gold > player7 gold if score player1 gold > player8 gold if score player1 gold > player9 gold if score player1 gold > player10 gold as @a[tag=player1] run function trilands:game/game_win

execute if score player2 gold > player1 gold if score player2 gold > player0 gold if score player2 gold > player3 gold if score player2 gold > player4 gold if score player2 gold > player5 gold if score player2 gold > player6 gold if score player2 gold > player7 gold if score player2 gold > player8 gold if score player2 gold > player9 gold if score player2 gold > player10 gold as @a[tag=player2] run function trilands:game/game_win

execute if score player3 gold > player1 gold if score player3 gold > player2 gold if score player3 gold > player0 gold if score player3 gold > player4 gold if score player3 gold > player5 gold if score player3 gold > player6 gold if score player3 gold > player7 gold if score player3 gold > player8 gold if score player3 gold > player9 gold if score player3 gold > player10 gold as @a[tag=player3] run function trilands:game/game_win

execute if score player4 gold > player1 gold if score player4 gold > player2 gold if score player4 gold > player3 gold if score player4 gold > player0 gold if score player4 gold > player5 gold if score player4 gold > player6 gold if score player4 gold > player7 gold if score player4 gold > player8 gold if score player4 gold > player9 gold if score player4 gold > player10 gold as @a[tag=player4] run function trilands:game/game_win

execute if score player5 gold > player1 gold if score player5 gold > player2 gold if score player5 gold > player3 gold if score player5 gold > player4 gold if score player5 gold > player0 gold if score player5 gold > player6 gold if score player5 gold > player7 gold if score player5 gold > player8 gold if score player5 gold > player9 gold if score player5 gold > player10 gold as @a[tag=player5] run function trilands:game/game_win

execute if score player6 gold > player1 gold if score player6 gold > player2 gold if score player6 gold > player3 gold if score player6 gold > player4 gold if score player6 gold > player5 gold if score player6 gold > player0 gold if score player6 gold > player7 gold if score player6 gold > player8 gold if score player6 gold > player9 gold if score player6 gold > player10 gold as @a[tag=player6] run function trilands:game/game_win

execute if score player7 gold > player1 gold if score player7 gold > player2 gold if score player7 gold > player3 gold if score player7 gold > player4 gold if score player7 gold > player5 gold if score player7 gold > player6 gold if score player7 gold > player0 gold if score player7 gold > player8 gold if score player7 gold > player9 gold if score player7 gold > player10 gold as @a[tag=player7] run function trilands:game/game_win

execute if score player8 gold > player1 gold if score player8 gold > player2 gold if score player8 gold > player3 gold if score player8 gold > player4 gold if score player8 gold > player5 gold if score player8 gold > player6 gold if score player8 gold > player7 gold if score player8 gold > player0 gold if score player8 gold > player9 gold if score player8 gold > player10 gold as @a[tag=player8] run function trilands:game/game_win

execute if score player9 gold > player1 gold if score player9 gold > player2 gold if score player9 gold > player3 gold if score player9 gold > player4 gold if score player9 gold > player5 gold if score player9 gold > player6 gold if score player9 gold > player7 gold if score player9 gold > player8 gold if score player9 gold > player0 gold if score player9 gold > player10 gold as @a[tag=player9] run function trilands:game/game_win

execute if score player10 gold > player1 gold if score player10 gold > player2 gold if score player10 gold > player3 gold if score player10 gold > player4 gold if score player10 gold > player5 gold if score player10 gold > player6 gold if score player10 gold > player7 gold if score player10 gold > player8 gold if score player10 gold > player9 gold if score player10 gold > player0 gold as @a[tag=player10] run function trilands:game/game_win

execute unless score data endround matches 0.. run function trilands:game/game_draw

tellraw @a {"text":" "}
tellraw @a ["",{"text":"All scores","bold":true,"color":"gold"},{"text":"\nScores of all players this game.\n "}]
execute as @a[tag=joined] run tellraw @a ["",{"selector":"@s","color":"gold"},{"text":": "},{"score":{"name":"@s","objective":"gold"}},{"text":" Gold"}]
tellraw @a {"text":" "}
execute as @a[tag=joined] run tellraw @s ["",{"text":" \n"},{"text":"Your score","bold":true,"color":"gold"},{"text":"\nAll your scores this game.\n\n"},{"text":"Kills","color":"gold"},{"text":": "},{"score":{"name":"@s","objective":"roundkills"}},{"text":" ("},{"score":{"name":"@s","objective":"killgold"},"color":"gray"},{"text":" Gold","color":"gray"},{"text":")\n"},{"text":"Outlived","color":"gold"},{"text":": "},{"score":{"name":"@s","objective":"outlived"}},{"text":" ("},{"score":{"name":"@s","objective":"survivegold"},"color":"gray"},{"text":" Gold","color":"gray"},{"text":")\n"},{"text":"Rounds won","color":"gold"},{"text":": "},{"score":{"name":"@s","objective":"roundswon"}},{"text":" ("},{"score":{"name":"@s","objective":"roundswongold"},"color":"gray"},{"text":" Gold","color":"gray"},{"text":")\n"},{"text":"Blocks broken","color":"gold"},{"text":": "},{"score":{"name":"@s","objective":"rounddestroyed"}},{"text":" ("},{"score":{"name":"@s","objective":"destroygold"},"color":"gray"},{"text":" Gold","color":"gray"},{"text":")\n "}]