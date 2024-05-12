execute if score @s cooldown matches 0 run scoreboard players add weather settings 1
execute if score @s cooldown matches 0 if score weather settings matches 1 run tellraw @s ["",{"text":"\n Switch weather to: ","color":"gold"},{"text":"Clear"},{"text":"\n "}]
execute if score @s cooldown matches 0 if score weather settings matches 1 run weather clear
execute if score @s cooldown matches 0 if score weather settings matches 2 run tellraw @s ["",{"text":"\n Switch weather to: ","color":"gold"},{"text":"Rain"},{"text":"\n "}]
execute if score @s cooldown matches 0 if score weather settings matches 2 run weather rain
execute if score @s cooldown matches 0 if score weather settings matches 2 run scoreboard players set weather settings 0
scoreboard players set @s cooldown 1