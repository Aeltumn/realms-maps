bossbar set minecraft:round players
bossbar set minecraft:gamestart players
bossbar set minecraft:waiting players
bossbar set minecraft:newround players
bossbar set minecraft:gracetimer players
bossbar set minecraft:lobbyreturn players

scoreboard players set data roundjoined 0
scoreboard players set data started 0
scoreboard players set data roundtimer -1
scoreboard players set data joined 0
scoreboard players add @a round 1
scoreboard players add data round 1
scoreboard players set data alive 0
scoreboard players set @a tridentreload 0
scoreboard players set @a reloading 0
scoreboard players set data gameround 0
scoreboard players set @a destroy 0
scoreboard players set data endround -1
scoreboard players set data newround -1
scoreboard players set data gracetime -1
scoreboard players set data settings 0

worldborder set 4000

execute as @a run function trilands:reset_player
function trilands:reset_map