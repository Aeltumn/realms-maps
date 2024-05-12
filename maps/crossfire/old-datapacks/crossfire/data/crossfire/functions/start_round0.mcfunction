# Give everyone some invulnerability
scoreboard players set @a[scores={map=0}] respawnshield 5

# Give everyone the tag to allow crossbow reloading
tag @a[scores={map=0}] add reloadcrossbow

# Remove pregame tag
tag @a[scores={map=0}] remove pregame

# Reset winners
scoreboard players reset Red winner
scoreboard players reset Yellow winner
scoreboard players reset Green winner
scoreboard players reset Blue winner
scoreboard players reset Draw0 winner

# Start the game!
execute as @a[scores={map=0}] at @s run playsound minecraft:event.raid.horn master @s ~ ~ ~ 100 1
execute as @a[scores={map=0}] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.2 1
title @a[scores={map=0}] subtitle {"text":""}
title @a[scores={map=0}] title {"text":"GO","bold":true,"color":"gold"}
bossbar set crossfire:timer0 players
bossbar set crossfire:timer0 players @a[scores={map=0}]
scoreboard players set game0 bar 1
scoreboard players set gametimer0 gametimer 300
function crossfire:timer0-2

# Open cages - party map (0)
clone 446 76 383 452 86 386 526 70 440
clone 446 76 388 452 86 391 526 70 399
clone 452 76 393 449 86 399 548 70 418
clone 449 76 407 452 86 401 507 70 418
