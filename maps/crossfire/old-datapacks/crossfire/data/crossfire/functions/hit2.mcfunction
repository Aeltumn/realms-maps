# Trigger hit effects
tag @s add died
title @s times 20 50 20
execute if entity @s[tag=player1] run tag @a remove spectateplayer1
execute if entity @s[tag=player2] run tag @a remove spectateplayer2
execute if entity @s[tag=player3] run tag @a remove spectateplayer3
execute if entity @s[tag=player4] run tag @a remove spectateplayer4
execute if entity @s[tag=player5] run tag @a remove spectateplayer5
execute if entity @s[tag=player6] run tag @a remove spectateplayer6
execute if entity @s[tag=player7] run tag @a remove spectateplayer7
execute if entity @s[tag=player8] run tag @a remove spectateplayer8
execute if entity @s[tag=player9] run tag @a remove spectateplayer9
execute if entity @s[tag=player10] run tag @a remove spectateplayer10
execute if entity @s[tag=player11] run tag @a remove spectateplayer11
clear @s[tag=!admin] #crossfire:crossbow
effect give @s minecraft:levitation 1 40 true
execute at @s run playsound minecraft:item.trident.riptide_3 master @a ~ ~ ~ 1 1
tag @s remove hit