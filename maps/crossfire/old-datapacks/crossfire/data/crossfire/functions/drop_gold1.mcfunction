# Kill the crate
kill @s
particle minecraft:explosion_emitter ~ ~ ~
playsound minecraft:entity.generic.explode block @a[scores={map=1}] ~ ~ ~

# Get a random gold number
# gold result is in X = {0,1}
scoreboard players set gold result 0
execute if predicate crossfire:coin_flip run scoreboard players add gold result 1

# Inform about power-up drop
execute if score gold result matches 0 run tellraw @a[scores={map=1}] ["",{"text":"The ","color":"white"},{"text":"Rapid Fire Power-up","color":"gold","hoverEvent":{"action":"show_text","value":["",{"text":"Increases the user's fire rate tremendously.","color":"white"}]}},{"text":" power-up has been dropped by a shiny crate!","color":"white"}]
execute if score gold result matches 1 run tellraw @a[scores={map=1}] ["",{"text":"The ","color":"white"},{"text":"Multishot Power-up","color":"light_purple","hoverEvent":{"action":"show_text","value":["",{"text":"Makes the user's crossbow shoot 3 arrows at a time.","color":"white"}]}},{"text":" power-up has been dropped by a shiny crate!","color":"white"}]

# Summon items
execute if score gold result matches 0 run summon minecraft:armor_stand ~ ~ ~ {Tags:["cleanup","sparkling","drop3","drop","1"],Marker:1b,ArmorItems:[{},{},{},{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:0},Count:1b}],Invisible:1}
execute if score gold result matches 1 run summon minecraft:armor_stand ~ ~ ~ {Tags:["cleanup","sparkling","drop4","drop","1"],Marker:1b,ArmorItems:[{},{},{},{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1},Count:1b}],Invisible:1}