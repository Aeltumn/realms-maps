execute if score armorshop shop matches 1.. run scoreboard players add armorshop shop 1
execute if score armorshop shop matches 200.. run scoreboard players set armorshop shop 0
execute if score armorshop shop matches 1.. run effect give @e[tag=armorshopitem] minecraft:invisibility 1000000 1 true

execute if score armorshop shop matches 2 at b2b58705-8c29-496a-9341-00f3294ec4ac run playsound minecraft:entity.villager.trade master @a ~ ~ ~ 0.2 1

execute if score armorshop shop matches 10 run summon minecraft:villager -172.5 3 153.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["armor1","armorshopitem","shopitem"]}
execute if score armorshop shop matches 10 run particle minecraft:cloud -172.5 57.5 153.5 0.2 0.2 0.2 0 10
execute if score armorshop shop matches 10 as b2b58705-8c29-496a-9341-00f3294ec4ac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score armorshop shop matches 10 run summon armor_stand -172.5 57 153.5 {Marker:1b,Tags:["armor1","armorshopitem"],NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,Rotation:[270f],ArmorItems:[{id:"leather_boots",Count:1b,tag:{display:{color:1184274}}},{id:"leather_leggings",Count:1b,tag:{display:{color:1184274}}},{id:"leather_chestplate",Count:1b,tag:{display:{color:1184274}}},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}


execute if score armorshop shop matches 20 run summon minecraft:villager -172.5 3 153.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["armor2","armorshopitem","shopitem"]}
execute if score armorshop shop matches 20 run particle minecraft:cloud -172.5 57.5 152.5 0.2 0.2 0.2 0 10
execute if score armorshop shop matches 20 as b2b58705-8c29-496a-9341-00f3294ec4ac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score armorshop shop matches 20 run summon armor_stand -172.5 57 152.5 {Marker:1b,Tags:["armor2","armorshopitem"],NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,Rotation:[270f],ArmorItems:[{id:"leather_boots",Count:1b,tag:{display:{color:13041687}}},{id:"leather_leggings",Count:1b,tag:{display:{color:13041687}}},{id:"leather_chestplate",Count:1b,tag:{display:{color:13041687}}},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}



execute if score armorshop shop matches 30 run summon minecraft:villager -172.5 3 153.5 {NoGravity:1b,NoAI:1,Silent:1,Tags:["armor3","armorshopitem","shopitem"]}
execute if score armorshop shop matches 30 run particle minecraft:cloud -172.5 57.5 151.5 0.2 0.2 0.2 0 10
execute if score armorshop shop matches 30 as b2b58705-8c29-496a-9341-00f3294ec4ac at @s run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score armorshop shop matches 30 run summon armor_stand -172.5 57 151.5 {Marker:1b,Tags:["armor3","armorshopitem"],NoBasePlate:1b,NoGravity:1b,ShowArms:1b,Small:1b,Rotation:[270f],ArmorItems:[{id:"leather_boots",Count:1b,tag:{display:{color:16777215}}},{id:"leather_leggings",Count:1b,tag:{display:{color:16777215}}},{id:"leather_chestplate",Count:1b,tag:{display:{color:16777215}}},{id:"light_gray_dye",Count:1b}],HandItems:[{},{}],DisabledSlots:2039583}




execute if score armorshop shop matches 10 run tp @e[tag=armor1,type=villager] -172.5 55.75 153.5
execute if score armorshop shop matches 20 run tp @e[tag=armor2,type=villager] -172.5 55.75 152.5
execute if score armorshop shop matches 30 run tp @e[tag=armor3,type=villager] -172.5 55.75 151.5



execute if score armorshop shop matches 170 run tp @e[tag=armor1] -166 3 148
execute if score armorshop shop matches 170 run particle minecraft:cloud -172.5 57.5 153.5 0.2 0.2 0.2 0 5
execute if score armorshop shop matches 170 at b2b58705-8c29-496a-9341-00f3294ec4ac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score armorshop shop matches 180 run tp @e[tag=armor2] -166 3 148
execute if score armorshop shop matches 180 run particle minecraft:cloud -172.5 57.5 152.5 0.2 0.2 0.2 0 5
execute if score armorshop shop matches 180 at b2b58705-8c29-496a-9341-00f3294ec4ac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1
execute if score armorshop shop matches 190 run tp @e[tag=armor3] -166 3 148
execute if score armorshop shop matches 190 run particle minecraft:cloud -172.5 57.5 151.5 0.2 0.2 0.2 0 5
execute if score armorshop shop matches 190 at b2b58705-8c29-496a-9341-00f3294ec4ac run playsound minecraft:block.barrel.close master @a ~ ~ ~ 0.2 1

execute if score armorshop shop matches 170 run kill @e[tag=armor1]
execute if score armorshop shop matches 180 run kill @e[tag=armor2]
execute if score armorshop shop matches 190 run kill @e[tag=armor3]