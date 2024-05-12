# Send bossbar to players
execute if score gametimer1 gametimer matches 0.. run execute store result bossbar crossfire:timer1 value run scoreboard players get gametimer1 gametimer
execute if score gametimer1 gametimer matches 2.. run bossbar set crossfire:timer1 name ["",{"text":"Game ends in: "},{"score":{"name":"gametimer1","objective":"gametimer"},"bold":true,"color":"gold"},{"text":" seconds."}]
execute if score gametimer1 gametimer matches 1 run bossbar set crossfire:timer1 name ["",{"text":"Game ends in: "},{"score":{"name":"gametimer1","objective":"gametimer"},"bold":true,"color":"gold"},{"text":" second."}]

# Spawn random crates
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 20 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 40 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 60 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 80 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 100 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 120 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 140 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 160 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 180 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 200 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 220 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 240 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 260 run function crossfire:spawn/random_crates1
execute if predicate crossfire:spawn_crates if score gametimer1 gametimer matches 280 run function crossfire:spawn/random_crates1

# End game if the game has only one team
scoreboard players set temp9 result 0
execute if entity @a[team=orange] run scoreboard players add temp9 result 1
execute if entity @a[team=magenta] run scoreboard players add temp9 result 1
execute if score temp9 result matches ..1 run scoreboard players set gametimer1 gametimer 0
execute if score temp9 result matches ..1 run tellraw @a[scores={map=1}] ["",{"text":"Only one team is left, the game will end now."}]

# Run game end
execute if score gametimer1 gametimer matches 0 run function crossfire:generated/end_game1

# Re-run the timer
execute if score gametimer1 gametimer matches 0.. run scoreboard players remove gametimer1 gametimer 1
execute if score gametimer1 gametimer matches 0.. run schedule function crossfire:timer1-2 1s replace
