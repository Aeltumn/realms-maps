
#Buy hats
execute as @a if score @s buy matches 1 if score @s totalgold matches ..99 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 1 if score @s totalgold matches 100.. run tag @s add ownedhat1
execute as @a if score @s buy matches 1 if score @s totalgold matches 100.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"green"},{"text":" Steering wheel\n "}]
execute as @a if score @s buy matches 1 if score @s totalgold matches 100.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 1 if score @s totalgold matches 100.. run scoreboard players remove @s totalgold 100

execute as @a if score @s buy matches 2 if score @s totalgold matches ..199 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 2 if score @s totalgold matches 200.. run tag @s add ownedhat2
execute as @a if score @s buy matches 2 if score @s totalgold matches 200.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"green"},{"text":" Eye patch\n "}]
execute as @a if score @s buy matches 2 if score @s totalgold matches 200.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 2 if score @s totalgold matches 200.. run scoreboard players remove @s totalgold 200


execute as @a if score @s buy matches 3 if score @s totalgold matches ..499 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 3 if score @s totalgold matches 500.. run tag @s add ownedhat3
execute as @a if score @s buy matches 3 if score @s totalgold matches 500.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"green"},{"text":" Pirate hat\n "}]
execute as @a if score @s buy matches 3 if score @s totalgold matches 500.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 3 if score @s totalgold matches 500.. run scoreboard players remove @s totalgold 500


#Buy particles
execute as @a if score @s buy matches 4 if score @s totalgold matches ..99 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 4 if score @s totalgold matches 100.. run tag @s add ownedparticle1
execute as @a if score @s buy matches 4 if score @s totalgold matches 100.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"aqua"},{"text":" Enchantment particles\n "}]
execute as @a if score @s buy matches 4 if score @s totalgold matches 100.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 4 if score @s totalgold matches 100.. run scoreboard players remove @s totalgold 100

execute as @a if score @s buy matches 5 if score @s totalgold matches ..199 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 5 if score @s totalgold matches 200.. run tag @s add ownedparticle2
execute as @a if score @s buy matches 5 if score @s totalgold matches 200.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"aqua"},{"text":" Skull particles\n "}]
execute as @a if score @s buy matches 5 if score @s totalgold matches 200.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 5 if score @s totalgold matches 200.. run scoreboard players remove @s totalgold 200


execute as @a if score @s buy matches 6 if score @s totalgold matches ..499 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 6 if score @s totalgold matches 500.. run tag @s add ownedparticle3
execute as @a if score @s buy matches 6 if score @s totalgold matches 500.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"aqua"},{"text":" Flame particles\n "}]
execute as @a if score @s buy matches 6 if score @s totalgold matches 500.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 6 if score @s totalgold matches 500.. run scoreboard players remove @s totalgold 500


#Buy armor
execute as @a if score @s buy matches 7 if score @s totalgold matches ..499 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 7 if score @s totalgold matches 500.. run tag @s add ownedarmor1
execute as @a if score @s buy matches 7 if score @s totalgold matches 500.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"yellow"},{"text":" Black colored armor\n "}]
execute as @a if score @s buy matches 7 if score @s totalgold matches 500.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 7 if score @s totalgold matches 500.. run scoreboard players remove @s totalgold 500

execute as @a if score @s buy matches 8 if score @s totalgold matches ..199 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 8 if score @s totalgold matches 200.. run tag @s add ownedarmor2
execute as @a if score @s buy matches 8 if score @s totalgold matches 200.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"yellow"},{"text":" Red colored armor\n "}]
execute as @a if score @s buy matches 8 if score @s totalgold matches 200.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 8 if score @s totalgold matches 200.. run scoreboard players remove @s totalgold 200


execute as @a if score @s buy matches 9 if score @s totalgold matches ..99 run tellraw @s {"text":"You do not have enough gold to buy this!","color":"red"}
execute as @a if score @s buy matches 9 if score @s totalgold matches 100.. run tag @s add ownedarmor3
execute as @a if score @s buy matches 9 if score @s totalgold matches 100.. run tellraw @s ["",{"text":"\n"},{"text":"You bought:","color":"yellow"},{"text":" White colored armor\n "}]
execute as @a if score @s buy matches 9 if score @s totalgold matches 100.. at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 0
execute as @a if score @s buy matches 9 if score @s totalgold matches 100.. run scoreboard players remove @s totalgold 100


execute as @a if score @s buy matches 1.. run scoreboard players enable @s buy
execute as @a if score @s buy matches 1.. run scoreboard players set @s buy 0