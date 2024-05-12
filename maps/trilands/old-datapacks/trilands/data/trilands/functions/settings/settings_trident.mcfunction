execute if score @s cooldown matches 0 run scoreboard players add tridentreload settings 1

execute if score @s cooldown matches 0 if score tridentreload settings matches 0 run tellraw @s ["",{"text":"\n "},{"text":"Trident recharge time:","color":"gold"},{"text":" Slow"},{"text":"\n "}]
execute if score @s cooldown matches 0 if score tridentreload settings matches 1 run tellraw @s ["",{"text":"\n "},{"text":"Trident recharge time:","color":"gold"},{"text":" Normal"},{"text":"\n "}]
execute if score @s cooldown matches 0 if score tridentreload settings matches 2 run tellraw @s ["",{"text":"\n "},{"text":"Trident recharge time:","color":"gold"},{"text":" Fast"},{"text":"\n "}]
execute if score @s cooldown matches 0 if score tridentreload settings matches 3.. run scoreboard players set tridentreload settings 0
execute if score @s cooldown matches 0 if score tridentreload settings matches 0 run tellraw @s ["",{"text":"\n "},{"text":"Trident recharge time:","color":"gold"},{"text":" Slow"},{"text":"\n "}]
scoreboard players set @s cooldown 1