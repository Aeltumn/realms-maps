# Rotate flight path entities
execute as @e[tag=flightpath5] at @s run tp @s ~ ~ ~ ~0.05 -10
# Rotate sparkling entities
execute as @e[tag=sparkling] run scoreboard players add @s age 1
execute as @e[tag=sparkling] if data entity @s {Marker:1b,NoGravity:1b} at @s run tp @s ~ ~ ~ ~1 ~

# Make copters fly
execute as @e[tag=supplycrate,tag=!crateless] at @s run tp @s ^ ^ ^0.2 ~2 ~
execute as @e[tag=crate,tag=!crateless,tag=!dropped] at @s run tp @s ^ ^ ^0.2 ~2 ~

# If crateless make copter(/crate) fly up
execute as @e[tag=crateless] at @s run tp @s ~ ~0.2 ~

# Kill crateless copters above y 75
execute as @e[tag=crateless] at @s if entity @s[y=120,dy=1000] run kill @s