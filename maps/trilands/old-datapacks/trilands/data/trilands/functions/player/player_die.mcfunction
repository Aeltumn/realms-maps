clear @s
tag @s remove drowning
tag @s add dead
scoreboard players set data alive 0
execute as @a[tag=roundjoined,tag=!dead] run scoreboard players add data alive 1

playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 100000000000000000000000000000 0

team leave @a[tag=joined]
tag @s add died
execute as @s[tag=player0hit] run tellraw @a ["",{"selector":"@a[tag=player0,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player0hit] run execute as @a[tag=player0] run function trilands:player/player_killer
execute as @s[tag=player0hit] run tag @s add killedbyplayer
execute as @s[tag=player1hit] run tellraw @a ["",{"selector":"@a[tag=player1,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player1hit] run execute as @a[tag=player1] run function trilands:player/player_killer
execute as @s[tag=player1hit] run tag @s add killedbyplayer
execute as @s[tag=player2hit] run tellraw @a ["",{"selector":"@a[tag=player2,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player2hit] run execute as @a[tag=player2] run function trilands:player/player_killer
execute as @s[tag=player2hit] run tag @s add killedbyplayer
execute as @s[tag=player3hit] run tellraw @a ["",{"selector":"@a[tag=player3,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player3hit] run execute as @a[tag=player3] run function trilands:player/player_killer
execute as @s[tag=player3hit] run tag @s add killedbyplayer
execute as @s[tag=player4hit] run tellraw @a ["",{"selector":"@a[tag=player4,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player4hit] run execute as @a[tag=player4] run function trilands:player/player_killer
execute as @s[tag=player4hit] run tag @s add killedbyplayer
execute as @s[tag=player5hit] run tellraw @a ["",{"selector":"@a[tag=player5,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player5hit] run execute as @a[tag=player5] run function trilands:player/player_killer
execute as @s[tag=player5hit] run tag @s add killedbyplayer
execute as @s[tag=player6hit] run tellraw @a ["",{"selector":"@a[tag=player6,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player6hit] run execute as @a[tag=player6] run function trilands:player/player_killer
execute as @s[tag=player6hit] run tag @s add killedbyplayer
execute as @s[tag=player7hit] run tellraw @a ["",{"selector":"@a[tag=player7,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player7hit] run execute as @a[tag=player7] run function trilands:player/player_killer
execute as @s[tag=player7hit] run tag @s add killedbyplayer
execute as @s[tag=player8hit] run tellraw @a ["",{"selector":"@a[tag=player8,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player8hit] run execute as @a[tag=player8] run function trilands:player/player_killer
execute as @s[tag=player8hit] run tag @s add killedbyplayer
execute as @s[tag=player9hit] run tellraw @a ["",{"selector":"@a[tag=player9,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player9hit] run execute as @a[tag=player9] run function trilands:player/player_killer
execute as @s[tag=player9hit] run tag @s add killedbyplayer
execute as @s[tag=player10hit] run tellraw @a ["",{"selector":"@a[tag=player10,limit=1]","color":"gold"},{"text":" killed "},{"selector":"@s","color":"gold"}]
execute as @s[tag=player10hit] run execute as @a[tag=player10] run function trilands:player/player_killer
execute as @s[tag=player10hit] run tag @s add killedbyplayer
tag @s remove died
execute as @s[tag=!killedbyplayer] run tellraw @a ["",{"selector":"@s","color":"gold"},{"text":" died."}]
tag @s remove killedbyplayer

team join ingame @a[tag=joined]
function trilands:map-teleport

scoreboard players add @a[tag=!dead,tag=joined] survivegold 15
scoreboard players add @a[tag=!dead,tag=joined] outlived 1
scoreboard players add @a[tag=!dead,tag=joined] totaloutlived 1
execute as @a[tag=!dead,tag=joined] if score @s challenge matches 6 run scoreboard players add @s[tag=!challengefinish] c_progress 15
execute as @a[tag=!dead,tag=joined] if score @s challenge matches 9 run scoreboard players add @s[tag=!challengefinish] c_progress 1