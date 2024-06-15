execute if score @s cooldown matches 0 run scoreboard players add data map 1
execute if score @s cooldown matches 0 if score data map matches 5 run scoreboard players set data map 1
execute if score @s cooldown matches 0 run tellraw @s ["",{"text":"\n Switched to map:","color":"gold"},{"text":" "},{"score":{"name":"data","objective":"map"}},{"text":"\n "}]
execute if score @s cooldown matches 0 run function trilands:reset_map
execute if score @s cooldown matches 0 run scoreboard players set @s cooldown 3