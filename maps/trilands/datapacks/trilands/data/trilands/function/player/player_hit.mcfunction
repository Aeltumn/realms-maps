execute as @s[tag=!player0] at @s if entity @e[type=trident,tag=player0,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player1] at @s if entity @e[type=trident,tag=player1,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player2] at @s if entity @e[type=trident,tag=player2,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player3] at @s if entity @e[type=trident,tag=player3,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player4] at @s if entity @e[type=trident,tag=player4,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player5] at @s if entity @e[type=trident,tag=player5,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player6] at @s if entity @e[type=trident,tag=player6,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player7] at @s if entity @e[type=trident,tag=player7,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player8] at @s if entity @e[type=trident,tag=player8,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player9] at @s if entity @e[type=trident,tag=player9,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit
execute as @s[tag=!player10] at @s if entity @e[type=trident,tag=player10,distance=..5,nbt={inGround:1b}] run function trilands:clear_hit

scoreboard players set data0 result 0

execute unless score data0 result matches 1 as @s[tag=!player0] at @s if entity @e[type=trident,tag=player0,distance=..5,nbt={inGround:1b}] run tag @s add player0hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player0] at @s if entity @e[type=trident,tag=player0,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player1] at @s if entity @e[type=trident,tag=player1,distance=..5,nbt={inGround:1b}] run tag @s add player1hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player1] at @s if entity @e[type=trident,tag=player1,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player2] at @s if entity @e[type=trident,tag=player2,distance=..5,nbt={inGround:1b}] run tag @s add player2hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player2] at @s if entity @e[type=trident,tag=player2,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player3] at @s if entity @e[type=trident,tag=player3,distance=..5,nbt={inGround:1b}] run tag @s add player3hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player3] at @s if entity @e[type=trident,tag=player3,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player4] at @s if entity @e[type=trident,tag=player4,distance=..5,nbt={inGround:1b}] run tag @s add player4hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player4] at @s if entity @e[type=trident,tag=player4,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player5] at @s if entity @e[type=trident,tag=player5,distance=..5,nbt={inGround:1b}] run tag @s add player5hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player5] at @s if entity @e[type=trident,tag=player5,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player6] at @s if entity @e[type=trident,tag=player6,distance=..5,nbt={inGround:1b}] run tag @s add player6hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player6] at @s if entity @e[type=trident,tag=player6,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player7] at @s if entity @e[type=trident,tag=player7,distance=..5,nbt={inGround:1b}] run tag @s add player7hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player7] at @s if entity @e[type=trident,tag=player7,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player8] at @s if entity @e[type=trident,tag=player8,distance=..5,nbt={inGround:1b}] run tag @s add player8hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player8] at @s if entity @e[type=trident,tag=player8,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player9] at @s if entity @e[type=trident,tag=player9,distance=..5,nbt={inGround:1b}] run tag @s add player9hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player9] at @s if entity @e[type=trident,tag=player9,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5

execute unless score data0 result matches 1 as @s[tag=!player10] at @s if entity @e[type=trident,tag=player10,distance=..5,nbt={inGround:1b}] run tag @s add player10hit
execute unless score data0 result matches 1 store success score data0 result as @s[tag=!player10] at @s if entity @e[type=trident,tag=player10,distance=..5,nbt={inGround:1b}] run scoreboard players set @s hittime 5
