# Check if a player in the game is currently in the water
execute as @a[tag=joined,tag=!waterdead,tag=!admin] at @s if block ~ ~ ~ water run function crossfire:touch_water