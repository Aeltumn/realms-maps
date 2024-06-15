execute if score @s cooldown matches 0 run scoreboard players add data rounds 1
execute if score @s cooldown matches 0 if score data rounds matches 11.. run scoreboard players set data rounds 2
tellraw @s ["",{"text":"\n "},{"text":"Switched to: ","color":"gold"},{"score":{"name":"data","objective":"rounds"}},{"text":"/10 rounds\n "}]
scoreboard players set @s cooldown 1