kill @e[type=item]

execute as @a if score @s destroy matches 75.. run effect give @s minecraft:speed 1000000 0 true
execute as @a if score @s destroy matches 150.. run effect give @s minecraft:jump_boost 1000000 0 true
execute as @a if score @s destroy matches 225.. run effect give @s minecraft:speed 1000000 1 true
execute as @a if score @s destroy matches 300.. run effect give @s minecraft:jump_boost 1000000 1 true

execute as @a store result score @s tridentcount run clear @s minecraft:trident 0
execute as @a if score @s tridentcount matches 2.. run clear @s minecraft:trident
execute as @a if score @s tridentcount matches 1.. if score @s reloading matches 1.. run clear @s minecraft:trident

execute as @a unless score @s settings matches 1.. run clear @s arrow


#Hats
execute as @a[tag=hat3selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:purple_dye"}]}] run clear @s minecraft:purple_dye
execute as @a[tag=hat3selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:purple_dye"}]}] run item replace entity @s armor.head with minecraft:purple_dye[minecraft:item_name="[{\"text\":\"\",\"italic\":false}]"] 1

execute as @a[tag=hat2selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:green_dye"}]}] run clear @s minecraft:green_dye
execute as @a[tag=hat2selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:green_dye"}]}] run item replace entity @s armor.head with minecraft:green_dye[minecraft:item_name="[{\"text\":\"\",\"italic\":false}]"] 1

execute as @a[tag=hat1selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:tripwire_hook"}]}] run clear @s minecraft:tripwire_hook
execute as @a[tag=hat1selected,gamemode=!spectator] unless score @s tutorial matches 0.. if entity @s[nbt=!{Inventory:[{Slot:103b,id:"minecraft:tripwire_hook"}]}] run item replace entity @s armor.head with minecraft:tripwire_hook[minecraft:item_name="[{\"text\":\"\",\"italic\":false}]"] 1




execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run clear @s minecraft:leather_chestplate
execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16777215]

execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run clear @s minecraft:leather_leggings
execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16777215]

execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run clear @s minecraft:leather_boots
execute as @a[tag=armor3selected] if entity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=16777215]


execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run clear @s minecraft:leather_chestplate
execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=13041687]

execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run clear @s minecraft:leather_leggings
execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=13041687]

execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run clear @s minecraft:leather_boots
execute as @a[tag=armor2selected] if entity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=13041687]


execute as @a[tag=armor1selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run clear @s minecraft:leather_chestplate
execute as @a[tag=armor1selected] if entity @s[nbt=!{Inventory:[{Slot:102b,id:"minecraft:leather_chestplate"}]}] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=1184274]

execute as @a[tag=armor1selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run clear @s minecraft:leather_leggings
execute as @a[tag=armor1selected] if entity @s[nbt=!{Inventory:[{Slot:101b,id:"minecraft:leather_leggings"}]}] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=1184274]

execute as @a[tag=armor1selected] if entity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run clear @s minecraft:leather_boots
execute as @a[tag=armor1selected] if ity @s[nbt=!{Inventory:[{Slot:100b,id:"minecraft:leather_boots"}]}] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=1184274]








#Lobbyent
execute as @a if score data started matches 0 unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":6}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=6]
execute as @a if score data started matches 0 unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":6}}]}] run item replace entity @s container.8 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=6,minecraft:item_name="[{\"text\":\"Statistics\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a[tag=!joined,tag=!admin] unless score data started matches 1.. unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":3}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=3]
execute as @a[tag=!joined,tag=!admin] unless score data started matches 1.. unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":3}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=3,minecraft:item_name="[{\"text\":\"Settings\",\"italic\":false,\"bold\":true,\"color\":\"red\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"}} 1

execute as @a[tag=!joined,tag=!admin] unless score data started matches 1.. unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":2}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=2]
execute as @a[tag=!joined,tag=!admin] unless score data started matches 1.. unless score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":2}}]}] run item replace entity @s container.4 with carrot_on_a_stick[minecraft:custom_model_data=2,minecraft:item_name="[{\"text\":\"Ready \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"}} 1

execute as @a[tag=joined,tag=!roundjoined,tag=!admin] if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":1}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=1}
execute as @a[tag=joined,tag=!roundjoined,tag=!admin] if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":1}}]}] run item replace entity @s container.4 with carrot_on_a_stick[minecraft:custom_model_data=1,minecraft:item_name="[{\"text\":\"Unready \",\"italic\":false,\"bold\":true,\"color\":\"red\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"}} 1


#Ingame
execute as @a[tag=joined,tag=!dead,tag=!admin] if score @s crossbowreload matches -1 if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:crossbow"}]}] run clear @s minecraft:crossbow
execute as @a[tag=joined,tag=!dead,tag=!admin] if score @s crossbowreload matches -1 if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:crossbow"}]}] run item replace entity @s container.3 with minecraft:crossbow[minecraft:item_name="[{\"text\":\"Grappling hook\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]",minecraft:enchantments={levels:{"minecraft:piercing": 10}},minecraft:unbreakable={},minecraft:charged_projectiles=[{id:"minecraft:arrow",Count:1b}]} 1

execute as @a[tag=joined,tag=!dead,tag=!admin] if score @s crossbowreload matches 0.. if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:yellow_dye"}]}] run clear @s minecraft:yellow_dye
execute as @a[tag=joined,tag=!dead,tag=!admin] if score @s crossbowreload matches 0.. if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:yellow_dye"}]}] run item replace entity @s container.3 with minecraft:yellow_dye[minecraft:item_name="[{\"text\":\"\",\"italic\":false}]"] 1

execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if score @s reloading matches 0 if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:trident"}]}] run clear @s minecraft:trident
execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if score @s reloading matches 0 if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:trident"}]}] run item replace entity @s container.4 with minecraft:trident[minecraft:item_name="[{\"text\":\"Trident\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click HOLD\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if score @s reloading matches 1 if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:blue_dye"}]}] run clear @s minecraft:blue_dye
execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data gracetime matches -1 if score data newround matches -1 if score data started matches 1 if score @s reloading matches 1 if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:blue_dye"}]}] run item replace entity @s container.4 with minecraft:blue_dye[minecraft:item_name="[{\"text\":\"\",\"italic\":false}]"] 1

execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":4}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=4]
execute as @a[tag=joined,tag=!dead,tag=!admin] if score data endround matches -1 if score data started matches 1 if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":4}}]}] run item replace entity @s container.8 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=4,minecraft:item_name="[{\"text\":\"Leave\",\"italic\":false,\"bold\":true,\"color\":\"red\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1



#Settings
execute as @a if score data started matches 0 if score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":4}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=4]
execute as @a if score data started matches 0 if score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:8b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":4}}]}] run item replace entity @s container.8 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=4,minecraft:item_name="[{\"text\":\"Back to lobby\",\"italic\":false,\"bold\":true,\"color\":\"red\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":7}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=7]
execute as @a if score data started matches 0 if score @s settings matches 1.. if entity @s[nbt=!{Inventory:[{Slot:4b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":7}}]}] run item replace entity @s container.4 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=7,minecraft:item_name="[{\"text\":\"Next setting\",\"italic\":false,\"bold\":true,\"color\":\"gold\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":5}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=5]
execute as @a if score data started matches 0 if score @s settings matches 1 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":5}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=5,minecraft:item_name="[{\"text\":\"Time\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 2 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":6}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=6]
execute as @a if score data started matches 0 if score @s settings matches 2 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":6}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=6,minecraft:item_name="[{\"text\":\"Map\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 3 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":8}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=8]
execute as @a if score data started matches 0 if score @s settings matches 3 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":8}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=8,minecraft:item_name="[{\"text\":\"Weather\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 4 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":9}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=9]
execute as @a if score data started matches 0 if score @s settings matches 4 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":9}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=9,minecraft:item_name="[{\"text\":\"Rounds\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 5 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":10}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=10]
execute as @a if score data started matches 0 if score @s settings matches 5 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":10}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=10,minecraft:item_name="[{\"text\":\"Round time\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1

execute as @a if score data started matches 0 if score @s settings matches 6 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":11}}]}] run clear @s minecraft:carrot_on_a_stick[minecraft:custom_model_data=11]
execute as @a if score data started matches 0 if score @s settings matches 6 if entity @s[nbt=!{Inventory:[{Slot:3b,id:"minecraft:carrot_on_a_stick",components:{"minecraft:custom_model_data":11}}]}] run item replace entity @s container.3 with minecraft:carrot_on_a_stick[minecraft:custom_model_data=11,minecraft:item_name="[{\"text\":\"Trident recharge time\",\"italic\":false,\"bold\":true,\"color\":\"yellow\"},{\"text\":\" \",\"italic\":false,\"bold\":true,\"color\":\"green\"},{\"text\":\"(\",\"italic\":false,\"bold\":false,\"color\":\"gray\"},{\"text\":\"Right click\",\"italic\":false,\"bold\":false,\"color\":\"white\"},{\"text\":\")\",\"italic\":false,\"bold\":false,\"color\":\"gray\"}]"] 1
