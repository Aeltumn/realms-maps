execute if score @s cooldown matches 0 run scoreboard players add roundtime settings 25
execute if score @s cooldown matches 0 if score roundtime settings matches 501.. run scoreboard players set roundtime settings 200
tellraw @s ["",{"text":"\n "},{"text":"Round time set to: ","color":"gold"},{"score":{"name":"roundtime","objective":"settings"}},{"text":" seconds.\n "}]
scoreboard players set @s cooldown 1