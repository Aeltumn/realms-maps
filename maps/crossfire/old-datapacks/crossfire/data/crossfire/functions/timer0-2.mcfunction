# Send bossbar to players
execute if score gametimer0 gametimer matches 0.. run execute store result bossbar crossfire:timer0 value run scoreboard players get gametimer0 gametimer
execute if score gametimer0 gametimer matches 2.. run bossbar set crossfire:timer0 name ["",{"text":"Game ends in: "},{"score":{"name":"gametimer0","objective":"gametimer"},"bold":true,"color":"gold"},{"text":" seconds."}]
execute if score gametimer0 gametimer matches 1 run bossbar set crossfire:timer0 name ["",{"text":"Game ends in: "},{"score":{"name":"gametimer0","objective":"gametimer"},"bold":true,"color":"gold"},{"text":" second."}]

# Spawn random crates
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 20 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 40 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 60 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 80 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 100 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 120 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 140 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 160 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 180 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 200 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 220 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 240 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 260 run function crossfire:spawn/random_crates0
execute if predicate crossfire:spawn_crates if score gametimer0 gametimer matches 280 run function crossfire:spawn/random_crates0

# End game if the game has only one team
scoreboard players set temp8 result 0
execute if entity @a[team=red] run scoreboard players add temp8 result 1
execute if entity @a[team=yellow] run scoreboard players add temp8 result 1
execute if entity @a[team=green] run scoreboard players add temp8 result 1
execute if entity @a[team=blue] run scoreboard players add temp8 result 1
execute if score temp8 result matches ..1 run scoreboard players set gametimer0 gametimer 0
execute if score temp8 result matches ..1 run tellraw @a[scores={map=0}] ["",{"text":"Only one team is left, the game will end now."}]