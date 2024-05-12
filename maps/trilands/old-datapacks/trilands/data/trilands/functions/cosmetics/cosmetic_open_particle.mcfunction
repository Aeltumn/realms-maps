execute if score particleshop shop matches 1.. run scoreboard players add particleshop shop 1
execute if score particleshop shop matches 200.. run scoreboard players set particleshop shop 0
execute if score particleshop shop matches 1.. run effect give @e[tag=particleshopitem] minecraft:invisibility 1000000 1 true

execute if score particleshop shop matches 2 at 3c018e7c-a355-464e-8d10-d41b779925d5 run playsound minecraft:entity.villager.trade master @a ~ ~ ~ 0.2 1

execute if score particleshop shop matches 10 run summon minecraft:villager -171.5 3 147.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["particle1","particleshopitem","shopitem"]}
execute if score particleshop shop matches 10 run particle minecraft:cloud -171.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 10 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score particleshop shop matches 10 run summon armor_stand -172 57 147 {Marker:1b,NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,ArmorItems:[{id:"leather_boots",Count:1b},{id:"leather_leggings",Count:1b},{id:"leather_chestplate",Count:1b},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583,Tags:["particle1"]}
execute if score particleshop shop matches 10 run tp @e[tag=particle1,type=villager] -171.5 56 147.5

execute if score particleshop shop matches 20 run summon minecraft:villager -171.5 3 147.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["particle2","particleshopitem","shopitem"]}
execute if score particleshop shop matches 20 run particle minecraft:cloud -170.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 20 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score particleshop shop matches 20 run summon armor_stand -171 57 147 {Marker:1b,NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,ArmorItems:[{id:"leather_boots",Count:1b},{id:"leather_leggings",Count:1b},{id:"leather_chestplate",Count:1b},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583,Tags:["particle2"]}
execute if score particleshop shop matches 20 run tp @e[tag=particle2,type=villager] -170.5 56 147.5

execute if score particleshop shop matches 30 run summon minecraft:villager -171.5 3 147.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["particle3","particleshopitem","shopitem"]}
execute if score particleshop shop matches 30 run particle minecraft:cloud -169.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 30 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score particleshop shop matches 30 run summon armor_stand -170 57 147 {Marker:1b,NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,ArmorItems:[{id:"leather_boots",Count:1b},{id:"leather_leggings",Count:1b},{id:"leather_chestplate",Count:1b},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583,Small:1b,Tags:["particle3"]}
execute if score particleshop shop matches 30 run tp @e[tag=particle3,type=villager] -169.5 56 147.5



execute if score particleshop shop matches 170 run tp @e[tag=particle1] -166 3 148
execute if score particleshop shop matches 170 run particle minecraft:cloud -171.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 170 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score particleshop shop matches 180 run tp @e[tag=particle2] -166 3 148
execute if score particleshop shop matches 180 run particle minecraft:cloud -170.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 180 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score particleshop shop matches 190 run tp @e[tag=particle3] -166 3 148
execute if score particleshop shop matches 190 run particle minecraft:cloud -169.5 57.5 147.5 0.2 0.2 0.2 0 5
execute if score particleshop shop matches 190 as 3c018e7c-a355-464e-8d10-d41b779925d5 at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1

execute if score particleshop shop matches 170.. run kill @e[tag=particle1]
execute if score particleshop shop matches 180.. run kill @e[tag=particle2]
execute if score particleshop shop matches 190.. run kill @e[tag=particle3]