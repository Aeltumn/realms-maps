execute unless score data endround matches 0.. as @e[type=arrow,tag=player0,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player0,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player1,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player1,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player2,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player2,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player3,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player3,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player4,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player4,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player5,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player5,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player6,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player6,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player7,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player7,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player8,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player8,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player9,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player9,tag=!dead] ~.5 ~ ~.5
execute unless score data endround matches 0.. as @e[type=arrow,tag=player10,nbt={inGround:1b}] at @s align xyz run tp @a[tag=player10,tag=!dead] ~.5 ~ ~.5
execute as @e[type=arrow] at @s run particle minecraft:crit ~ ~ ~ 0 0 0 0 10
execute as @e[type=arrow] at @s unless block ~ 0 ~ minecraft:white_glazed_terracotta run kill @s
execute as @e[type=arrow,nbt={inGround:1b}] run kill @s