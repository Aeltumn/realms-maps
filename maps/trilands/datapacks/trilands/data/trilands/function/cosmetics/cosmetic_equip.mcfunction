#Unequip Hats
execute as @s[tag=hat1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat1] run tag @s add unequip
execute as @s[tag=hat1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat1] run tag @s remove hat1selected
execute as @s[tag=hat2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat2] run tag @s add unequip
execute as @s[tag=hat2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat2] run tag @s remove hat2selected
execute as @s[tag=hat3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat3] run tag @s add unequip
execute as @s[tag=hat3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat3] run tag @s remove hat3selected


#Unequip particles
execute as @s[tag=particle1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle1] run tag @s add unequip2
execute as @s[tag=particle1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle1] run tag @s remove particle1selected
execute as @s[tag=particle2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle2] run tag @s add unequip2
execute as @s[tag=particle2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle2] run tag @s remove particle2selected
execute as @s[tag=particle3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle3] run tag @s add unequip2
execute as @s[tag=particle3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle3] run tag @s remove particle3selected


#Unequip armor
execute as @s[tag=armor1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run tag @s add unequip3
execute as @s[tag=armor1selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run tag @s remove armor1selected
execute as @s[tag=armor2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run tag @s add unequip3
execute as @s[tag=armor2selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run tag @s remove armor2selected
execute as @s[tag=armor3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run tag @s add unequip3
execute as @s[tag=armor3selected] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run tag @s remove armor3selected



#Remove other tags
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hatshopitem] run tag @s[tag=!unequip] remove hat1selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hatshopitem] run tag @s[tag=!unequip] remove hat2selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hatshopitem] run tag @s[tag=!unequip] remove hat3selected

execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particleshopitem] run tag @s[tag=!unequip] remove particle1selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particleshopitem] run tag @s[tag=!unequip] remove particle2selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particleshopitem] run tag @s[tag=!unequip] remove particle3selected

execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armorshopitem] run tag @s[tag=!unequip] remove armor1selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armorshopitem] run tag @s[tag=!unequip] remove armor2selected
execute as @s[tag=!unequip] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armorshopitem] run tag @s[tag=!unequip] remove armor3selected



##Equip hats
#Send message if player does not own the hat.
execute unless score data1 result matches 1 as @s[tag=!unequip,tag=!ownedhat1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat1] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"green"},{"text":"Steering wheel\n"},{"text":"Price: ","color":"green"},{"text":"100 Gold\n\n"},{"text":"Click ","color":"green"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 1"}},{"text":" to buy!","color":"green"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip,tag=!ownedhat2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat2] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"green"},{"text":"Eye patch\n"},{"text":"Price: ","color":"green"},{"text":"200 Gold\n\n"},{"text":"Click ","color":"green"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 2"}},{"text":" to buy!","color":"green"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip,tag=!ownedhat3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat3] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"green"},{"text":"Pirate hat\n"},{"text":"Price: ","color":"green"},{"text":"500 Gold\n\n"},{"text":"Click ","color":"green"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 3"}},{"text":" to buy!","color":"green"},{"text":"\n\n "}]

#Equip the hat if possible.
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip,tag=ownedhat1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat1] run tag @s[tag=!unequip] add hat1selected
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip,tag=ownedhat2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat2] run tag @s[tag=!unequip] add hat2selected
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip,tag=ownedhat3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=hat3] run tag @s[tag=!unequip] add hat3selected



##Equip particles
#Send message if player does not own the particle.
execute unless score data1 result matches 1 as @s[tag=!unequip2,tag=!ownedparticle1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle1] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"aqua"},{"text":"Enchantment particles\n"},{"text":"Price: ","color":"aqua"},{"text":"100 Gold\n\n"},{"text":"Click ","color":"aqua"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 4"}},{"text":" to buy!","color":"aqua"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip2,tag=!ownedparticle2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle2] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"aqua"},{"text":"Skull particles\n"},{"text":"Price: ","color":"aqua"},{"text":"200 Gold\n\n"},{"text":"Click ","color":"aqua"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 5"}},{"text":" to buy!","color":"aqua"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip2,tag=!ownedparticle3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle3] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"aqua"},{"text":"Flame particles\n"},{"text":"Price: ","color":"aqua"},{"text":"500 Gold\n\n"},{"text":"Click ","color":"aqua"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 6"}},{"text":" to buy!","color":"aqua"},{"text":"\n\n "}]

#Equip the particles if possible.
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip2,tag=ownedparticle1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle1] run tag @s[tag=!unequip] add particle1selected
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip2,tag=ownedparticle2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle2] run tag @s[tag=!unequip] add particle2selected
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip2,tag=ownedparticle3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=particle3] run tag @s[tag=!unequip] add particle3selected



##Equip armor
#Send message if player does not own the armor.
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=!ownedarmor1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"yellow"},{"text":"Black colored armor\n"},{"text":"Price: ","color":"yellow"},{"text":"500 Gold\n\n"},{"text":"Click ","color":"yellow"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 7"}},{"text":" to buy!","color":"yellow"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=!ownedarmor2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"yellow"},{"text":"Red colored armor\n"},{"text":"Price: ","color":"yellow"},{"text":"200 Gold\n\n"},{"text":"Click ","color":"yellow"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 8"}},{"text":" to buy!","color":"yellow"},{"text":"\n\n "}]
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=!ownedarmor3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run tellraw @s ["",{"text":"\n\n"},{"text":"Item: ","color":"yellow"},{"text":"White colored armor\n"},{"text":"Price: ","color":"yellow"},{"text":"100 Gold\n\n"},{"text":"Click ","color":"yellow"},{"text":"here","clickEvent":{"action":"run_command","value":"/trigger buy set 9"}},{"text":" to buy!","color":"yellow"},{"text":"\n\n "}]

#Equip the armor if possible.
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run tag @s[tag=!unequip] add armor1selected
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=1184274]
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=1184274]
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip3,tag=ownedarmor1] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor1] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=1184274]

execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run tag @s[tag=!unequip] add armor2selected
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=13041687]
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=13041687]
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip3,tag=ownedarmor2] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor2] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=13041687]

execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run tag @s[tag=!unequip] add armor3selected
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16777215]
execute unless score data1 result matches 1 as @s[tag=!unequip3,tag=ownedarmor3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16777215]
execute unless score data1 result matches 1 store success score data1 result as @s[tag=!unequip3,tag=ownedarmor3] if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=armor3] run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=16777215]





#Reset player inventory if needed
execute as @s[tag=unequip] run item replace entity @s armor.head with air
execute as @s[tag=unequip3] run item replace entity @s armor.chest with air
execute as @s[tag=unequip3] run item replace entity @s armor.legs with air
execute as @s[tag=unequip3] run item replace entity @s armor.feet with air

execute as @s[tag=unequip] run title @s actionbar {"text":"Unequipped!","color":"red"}
execute as @s[tag=unequip2] run title @s actionbar {"text":"Unequipped!","color":"red"}
execute as @s[tag=unequip3] run title @s actionbar {"text":"Unequipped!","color":"red"}
execute as @s[tag=unequip] as @s at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000000000000 1
execute as @s[tag=unequip2] as @s at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000000000000 1
execute as @s[tag=unequip3] as @s at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000000000000 1
execute as @s if score data1 result matches 1 run title @s actionbar {"text":"Equipped!","color":"green"}
execute as @s if score data1 result matches 1 as @s at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 1000000000000000000000000 1

tag @s remove unequip
tag @s remove unequip2
tag @s remove unequip3