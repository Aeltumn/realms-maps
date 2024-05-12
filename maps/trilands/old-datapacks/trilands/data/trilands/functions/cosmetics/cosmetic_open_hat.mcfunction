execute if score hatshop shop matches 1.. run scoreboard players add hatshop shop 1
execute if score hatshop shop matches 200.. run scoreboard players set hatshop shop 0
execute if score hatshop shop matches 1.. run effect give @e[tag=hatshopitem] minecraft:invisibility 1000000 1 true

execute if score hatshop shop matches 2 at 38e0d055-4805-41b2-8e9d-9a25e33e0bac run playsound minecraft:entity.villager.trade master @a ~ ~ ~ 0.2 1

execute if score hatshop shop matches 10 run summon minecraft:villager -165.5 3 147.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["hat3","hatshopitem","shopitem"]}
execute if score hatshop shop matches 10 run particle minecraft:cloud -165.5 57.5 147.5 0.2 0.2 0.2 0 10
execute if score hatshop shop matches 10 as 38e0d055-4805-41b2-8e9d-9a25e33e0bac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score hatshop shop matches 10 run summon armor_stand -165.5 57.05 147.5 {Invisible:1,Invulnerable:1b,PersistenceRequired:1b,NoGravity:1b,Tags:["hat1","hatshopitem"],Rotation:[90f],Marker:1b,ArmorItems:[{},{},{},{id:"black_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}


execute if score hatshop shop matches 20 run summon minecraft:villager -165.5 3 148.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["hat2","hatshopitem","shopitem"]}
execute if score hatshop shop matches 20 run particle minecraft:cloud -165.5 57.5 148.5 0.2 0.2 0.2 0 10
execute if score hatshop shop matches 20 as 38e0d055-4805-41b2-8e9d-9a25e33e0bac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score hatshop shop matches 20 run summon armor_stand -165.5 57.05 148.5 {Invisible:1,Invulnerable:1b,PersistenceRequired:1b,NoGravity:1b,Tags:["hat2","hatshopitem"],Rotation:[90f],Marker:1b,ArmorItems:[{},{},{},{id:"brown_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}



execute if score hatshop shop matches 30 run summon minecraft:villager -165.5 3 149.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["hat1","hatshopitem","shopitem"]}
execute if score hatshop shop matches 30 run particle minecraft:cloud -165.5 57.5 149.5 0.2 0.2 0.2 0 10
execute if score hatshop shop matches 30 as 38e0d055-4805-41b2-8e9d-9a25e33e0bac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score hatshop shop matches 30 run summon armor_stand -165.5 57.05 149.5 {Invisible:1,Invulnerable:1b,PersistenceRequired:1b,NoGravity:1b,Tags:["hat3","hatshopitem"],Rotation:[90f],Marker:1b,ArmorItems:[{},{},{},{id:"white_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}




execute if score hatshop shop matches 10 run tp @e[tag=hat3,type=villager] -165.5 55.75 147.5
execute if score hatshop shop matches 20 run tp @e[tag=hat2,type=villager] -165.5 55.75 148.5
execute if score hatshop shop matches 30 run tp @e[tag=hat1,type=villager] -165.5 55.75 149.5



execute if score hatshop shop matches 170 run tp @e[tag=hat1] -166 3 148
execute if score hatshop shop matches 170 run particle minecraft:cloud -165.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score hatshop shop matches 170 at 38e0d055-4805-41b2-8e9d-9a25e33e0bac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score hatshop shop matches 180 run tp @e[tag=hat2] -166 3 148
execute if score hatshop shop matches 180 run particle minecraft:cloud -165.5 57.5 148.5 0.2 0.2 0.2 0 5
execute if score hatshop shop matches 180 at 38e0d055-4805-41b2-8e9d-9a25e33e0bac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score hatshop shop matches 190 run tp @e[tag=hat3] -166 3 148
execute if score hatshop shop matches 190 run particle minecraft:cloud -165.5 57.5 149.5 0.2 0.2 0.2 0 5
execute if score hatshop shop matches 190 at 38e0d055-4805-41b2-8e9d-9a25e33e0bac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1

execute if score hatshop shop matches 170 run kill @e[tag=hat1]
execute if score hatshop shop matches 180 run kill @e[tag=hat2]
execute if score hatshop shop matches 190 run kill @e[tag=hat3]