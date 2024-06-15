clear @a[tag=joined]
bossbar set minecraft:gamestart players
playsound minecraft:block.beacon.activate master @a[tag=!admin] ~ ~ ~ 100000000000000000000000000000000000000 1
function trilands:roundplayers
scoreboard players set data started 1
team join ingame @a[tag=joined]
function trilands:game/game_round
scoreboard players set @a tutorial -1
worldborder set 40
scoreboard players set data gracetime 10