execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000 0
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000 0

execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run title @s actionbar [{"text":" "}]
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run title @s times 20 20 20
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run title @s subtitle {"text":"\uE003"}

execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run title @s actionbar [{"text":" "}]
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run title @s times 20 20 20
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run title @s subtitle {"text":"\uE003"}


execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run title @s title [{"text":"NOT READY","color":"red"}]
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run team join notready @s
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run tag @s add selected
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run tag @s remove joined
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run bossbar set minecraft:waiting players
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run bossbar set minecraft:gamestart players
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run bossbar set minecraft:gamestart players @a[tag=joined]
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run bossbar set minecraft:waiting players @a[tag=joined]

execute as @s[tag=!selected] if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run title @s title [{"text":"READY","color":"green"}]
execute as @s[tag=!selected] if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run team join ready @s
execute as @s[tag=!selected] if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run tag @s add joined
execute as @s[tag=!selected] if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run bossbar set minecraft:waiting players @s
execute as @s[tag=!selected] if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run item replace entity @s container.3 with air

execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:1}}}] run scoreboard players set @s cooldown 2
execute as @s if score data started matches 0 if entity @s[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick",tag:{CustomModelData:2}}}] run scoreboard players set @s cooldown 2