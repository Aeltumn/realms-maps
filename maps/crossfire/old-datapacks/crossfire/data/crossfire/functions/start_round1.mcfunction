# Give everyone some invulnerability
scoreboard players set @a[scores={map=1}] respawnshield 5

# Give everyone the tag to allow crossbow reloading
tag @a[scores={map=1}] add reloadcrossbow

# Remove pregame tag
tag @a[scores={map=1}] remove pregame

# Reset Winners
scoreboard players reset Magenta winner
scoreboard players reset Orange winner
scoreboard players reset Draw1 winner

# Start the game!
execute as @a[scores={map=1}] at @s run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100 1
execute as @a[scores={map=1}] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.2 1
title @a[scores={map=1}] subtitle {"text":""}
title @a[scores={map=1}] title {"text":"GO","bold":true,"color":"gold"}
bossbar set crossfire:timer1 players
bossbar set crossfire:timer1 players @a[scores={map=1}]
scoreboard players set game1 bar 1
scoreboard players set gametimer1 gametimer 300
function crossfire:timer1-2

# Open cages - duel map (1)
clone 446 77 364 440 87 361 526 70 274
clone 446 77 369 440 87 366 526 70 315
