# Remove redundant tags
tag @s remove waterdead
tag @s remove spectating
tag @s remove died
tag @s remove spectateplayer1
tag @s remove spectateplayer2
tag @s remove spectateplayer3
tag @s remove spectateplayer4
tag @s remove spectateplayer5
tag @s remove spectateplayer6
tag @s remove spectateplayer7
tag @s remove spectateplayer8
tag @s remove spectateplayer9
tag @s remove spectateplayer10
tag @s remove spectateplayer11
scoreboard players set @s deadtimer 6
scoreboard players set @s respawnshield 5

# Remove from currently spectated entity
spectate @s
function crossfire:init_player

# Play a sound to everyone in the game so they are notified of the respawn
execute if entity @s[scores={map=0}] as @a[scores={map=0}] at @s run playsound minecraft:item.armor.equip_turtle master @s ~ ~ ~ 0.4
execute if entity @s[scores={map=1}] as @a[scores={map=1}] at @s run playsound minecraft:item.armor.equip_turtle master @s ~ ~ ~ 0.4