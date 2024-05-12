# Get a random location0 number
scoreboard players set location0 result 0
execute if predicate crossfire:coin_flip run scoreboard players add location0 result 1
execute if predicate crossfire:coin_flip run scoreboard players add location0 result 2
execute if predicate crossfire:coin_flip run scoreboard players add location0 result 4

# Spawn the crate in the correct location
# Iron crate
execute if score location0 result matches 0 if predicate crossfire:iron_chance positioned 529 80 411 run function crossfire:spawn/iron_crate0
execute if score location0 result matches 1 if predicate crossfire:iron_chance positioned 539 80 421 run function crossfire:spawn/iron_crate0
execute if score location0 result matches 2 if predicate crossfire:iron_chance positioned 529 80 431 run function crossfire:spawn/iron_crate0
execute if score location0 result matches 3 if predicate crossfire:iron_chance positioned 519 80 421 run function crossfire:spawn/iron_crate0

# Gold crate
execute if score location0 result matches 4 if predicate crossfire:gold_chance positioned 537 80 413 run function crossfire:spawn/gold_crate0
execute if score location0 result matches 5 if predicate crossfire:gold_chance positioned 537 80 429 run function crossfire:spawn/gold_crate0
execute if score location0 result matches 6 if predicate crossfire:gold_chance positioned 521 80 429 run function crossfire:spawn/gold_crate0
execute if score location0 result matches 7 if predicate crossfire:gold_chance positioned 521 80 413 run function crossfire:spawn/gold_crate0