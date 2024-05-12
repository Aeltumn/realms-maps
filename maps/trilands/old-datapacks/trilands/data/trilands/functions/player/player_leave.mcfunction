scoreboard players remove data alive 1
scoreboard players remove data joined 1
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 100000000000000000000000000000 0

team leave @s
tellraw @a ["",{"selector":"@s","color":"red"},{"text":" left the arena.","color":"red"}]
team join spectate @s

execute as @s run function trilands:reset_player
execute if score data alive matches ..1 run function trilands:new_round