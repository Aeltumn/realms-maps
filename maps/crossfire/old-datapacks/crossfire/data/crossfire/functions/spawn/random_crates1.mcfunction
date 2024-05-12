# Get a random location1 number
scoreboard players set location1 result 0
execute if predicate crossfire:coin_flip run scoreboard players add location1 result 1
execute if score location1 result matches 0 if predicate crossfire:coin_flip run scoreboard players add location1 result 2

# Spawn the crate in the correct location
# Iron crate
execute if score location1 result matches 0 if predicate crossfire:iron_chance positioned 517 80 296 run function crossfire:spawn/iron_crate1
execute if score location1 result matches 1 if predicate crossfire:iron_chance positioned 541 80 296 run function crossfire:spawn/iron_crate1

# Gold crate
execute if score location1 result matches 2 if predicate crossfire:gold_chance positioned 529 80 296 run function crossfire:spawn/gold_crate1