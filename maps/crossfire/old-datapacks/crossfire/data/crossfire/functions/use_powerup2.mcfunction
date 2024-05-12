# Rapid Fire
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:0}}}] run effect give @s minecraft:unluck 20 0
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:0}}}] at @s run playsound minecraft:item.armor.equip_diamond master @a ~ ~ ~
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:0}}}] run item replace entity @s weapon.mainhand with air

# Multishot
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run effect give @s minecraft:luck 20 0
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] at @s run playsound minecraft:item.armor.equip_diamond master @a ~ ~ ~
# Give the multishot crossbow if you already have a reloaded crossbow
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] if entity @s[tag=givecrossbow,tag=!spectating,tag=!died,predicate=crossfire:has_multishot] if score @s timer matches 40.. run function crossfire:give_crossbow_multishot
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] if entity @s[tag=givecrossbow,tag=!spectating,tag=!died,predicate=crossfire:has_multishot] if entity @s[nbt={Inventory:[{Slot:1b,id:"minecraft:crossbow",tag:{Charged:1b}}]}] run function crossfire:give_crossbow_multishot
execute if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run item replace entity @s weapon.mainhand with air

# Map switch items
scoreboard players set temp3 result 0
execute store success score temp3 result if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:3}}}] as @s run function crossfire:change_map
execute store success score temp3 result if score temp3 result matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] as @s run function crossfire:change_map

# Quit game item
execute if score temp3 result matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:4}}}] as @s run function crossfire:reset_player