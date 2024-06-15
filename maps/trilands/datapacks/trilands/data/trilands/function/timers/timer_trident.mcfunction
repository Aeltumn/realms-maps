execute as @a if score data endround matches -1 if score data newround matches -1 if score @s reloading matches 1.. run scoreboard players add @s tridentreload 1

#Fast
execute as @a if score tridentreload settings matches 2 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 10.. at @s run playsound minecraft:block.beacon.power_select master @s ~ ~ ~ 0.5 2
execute as @a if score tridentreload settings matches 2 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 10.. run scoreboard players set @s reloading 0
execute as @a if score tridentreload settings matches 2 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 10.. run scoreboard players set @s tridentreload 0


#Normal
execute as @a if score tridentreload settings matches 1 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 20.. at @s run playsound minecraft:block.beacon.power_select master @s ~ ~ ~ 0.5 2
execute as @a if score tridentreload settings matches 1 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 20.. run scoreboard players set @s reloading 0
execute as @a if score tridentreload settings matches 1 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 20.. run scoreboard players set @s tridentreload 0


#Slow
execute as @a if score tridentreload settings matches 0 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 30.. at @s run playsound minecraft:block.beacon.power_select master @s ~ ~ ~ 0.5 2
execute as @a if score tridentreload settings matches 0 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 30.. run scoreboard players set @s reloading 0
execute as @a if score tridentreload settings matches 0 if score data endround matches -1 if score data newround matches -1 if score @s[tag=roundjoined] tridentreload matches 30.. run scoreboard players set @s tridentreload 0
