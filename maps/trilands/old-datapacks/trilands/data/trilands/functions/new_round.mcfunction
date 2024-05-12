execute if score data joined matches ..1 if score data roundjoined matches ..1 run execute store result score data gameround run scoreboard players get data rounds
scoreboard players add @a round 1
scoreboard players add data round 1

execute if score data gameround < data rounds run clear @a[tag=joined]
execute if score data gameround < data rounds run title @a[tag=!admin] title {"text":"Round ended!","bold":true,"color":"red"}
execute if score data gameround < data rounds run title @a subtitle {"text":" "}
execute if score data gameround < data rounds run scoreboard players set @a destroy 0
execute if score data gameround < data rounds run effect clear @a
execute if score data gameround < data rounds as @a[tag=joined] if score @s challenge matches 7 run scoreboard players add @s[tag=!challengefinish] c_progress 1
execute if score data gameround < data rounds run effect give @a minecraft:saturation 1000000 255 true
execute if score data gameround < data rounds run effect give @a minecraft:weakness 1000000 255 true
execute if score data gameround < data rounds run effect give @a minecraft:regeneration 1000000 255 true
execute if score data gameround < data rounds run bossbar set minecraft:round players
execute if score data gameround < data rounds run scoreboard players set data newround 10
execute if score data gameround < data rounds run scoreboard players set data roundtimer -1

execute if score data gameround = data rounds as @a[tag=!dead,tag=joined] if score @s challenge matches 5 run scoreboard players add @s[tag=!challengefinish] c_progress 1
execute if score data gameround = data rounds run scoreboard players set data endround 20
execute if score data gameround = data rounds run kill @e[type=minecraft:arrow]
execute if score data gameround = data rounds run kill @e[type=minecraft:trident]
execute if score data gameround = data rounds run playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 100000000000000 1
execute if score data gameround = data rounds run gamemode adventure @a[tag=!admin]
execute if score data gameround = data rounds run clear @a[tag=!admin]
execute if score data gameround = data rounds run bossbar set minecraft:lobbyreturn players @a[tag=!admin]
execute if score data gameround = data rounds run worldborder set 4000
execute if score data gameround = data rounds run scoreboard players add @a[tag=joined] gamesplayed 1
execute if score data gameround = data rounds run effect clear @a
execute if score data gameround = data rounds run effect give @a[tag=!admin] minecraft:weakness 1000000 1 true
execute if score data gameround = data rounds run scoreboard players set data roundtimer -1
execute if score data gameround = data rounds run scoreboard players set data gracetime -1
execute if score data gameround = data rounds run scoreboard players set data newround -1
execute if score data gameround = data rounds run scoreboard players set @a destroy 0
execute if score data gameround = data rounds run tp @a[tag=!admin] -192.5 44 293.5 135 0
execute if score data gameround = data rounds run tag @a remove dead
execute if score data gameround = data rounds run function trilands:game/game_endscores