scoreboard players add @a firstjoined 0
scoreboard players add @a round 0
scoreboard players add @a water 0
scoreboard players add @a onland 0
fill -194 41 209 -238 43 265 water replace air


execute as @a[tag=!admin] if score @s firstjoined matches 0 run title @s subtitle {"text":"By Acented, Aeltumn & Grafisch"}
execute as @a[tag=!admin] if score @s firstjoined matches 0 run title @s title {"text":"TRILANDS","color":"dark_aqua"}
execute as @a[tag=!admin] if score @s firstjoined matches 0 run function trilands:reset_player


execute as @a[tag=!admin] if score @s tutorial matches -1 unless score @s round = data round run function trilands:reset_player
execute as @a[tag=!admin] unless score @s round = data round run scoreboard players operation @s round = data round

execute unless score data endround matches 0.. run scoreboard players set data testonline 0
execute unless score data endround matches 0.. as @a[tag=!admin,tag=!spectate] run scoreboard players add data testonline 1

execute unless score data endround matches 0.. if score data testonline < data online run team empty notready
execute unless score data endround matches 0.. if score data testonline < data online run team empty ready
execute unless score data endround matches 0.. if score data testonline < data online run team empty ingame
execute unless score data endround matches 0.. if score data testonline < data online run team empty spectate


execute unless score data endround matches 0.. run scoreboard players set data online 0
execute unless score data endround matches 0.. as @a[tag=!admin,tag=!spectate] run scoreboard players add data online 1

execute unless score data endround matches 0.. run scoreboard players set data roundjoined 0
execute unless score data endround matches 0.. as @a[tag=!admin,tag=roundjoined] run scoreboard players add data roundjoined 1

execute unless score data endround matches 0.. run scoreboard players set data joined 0
execute unless score data endround matches 0.. as @a[tag=joined,tag=!dead] run scoreboard players add data joined 1

execute as @a[gamemode=spectator] if score data started matches 1 run item replace entity @s armor.head with minecraft:carved_pumpkin

execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches ..1 run execute store result score data gameround run scoreboard players get data rounds
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. as @a if score @s challenge matches 5 run scoreboard players add @s[tag=!challengefinish,tag=!dead,tag=roundjoined] c_progress 1
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. run scoreboard players add @a[tag=joined,tag=!dead] roundswon 1
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. run scoreboard players add @a[tag=joined,tag=!dead] roundswongold 40
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. run gamemode spectator @a[tag=dead]
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. run tag @a remove dead
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches 2.. run function trilands:new_round
execute unless score data endround matches 0.. if score data started matches 1 if score data joined matches ..1 if score data roundjoined matches ..1 run function trilands:new_round

execute if score data joined = data online if score data starttimer matches 11.. run scoreboard players set data starttimer 10

execute if score data started matches 0 run team join notready @a[tag=!joined]
execute if score data started matches 0 run team join ready @a[tag=joined,tag=!dead]
execute if score data started matches 1 run team join ingame @a[tag=roundjoined,tag=!dead,gamemode=!spectator]
execute if score data started matches 1 run team join spectate @a[tag=dead]
execute if score data started matches 1 run team join spectate @a[tag=!joined]
execute if score data started matches 1 run team join spectate @a[gamemode=spectator]

execute as @a[tag=admin,team=!admin] run team join admin
execute as @a[team=admin,tag=!admin] run function trilands:reset_player