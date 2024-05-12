execute as @a if score @s crossbowuse matches 1.. run function trilands:player/player_arrow
execute as @a if score @s crossbowuse matches 1.. run scoreboard players add @s usedgrapling 1
execute as @a if score @s crossbowuse matches 1.. if score @s challenge matches 4 run scoreboard players add @s[tag=!challengefinish] c_progress 1
execute as @a if score @s crossbowuse matches 1.. run scoreboard players set @s crossbowreload 300
execute as @a if score @s crossbowuse matches 1.. run scoreboard players set @s crossbowuse 0