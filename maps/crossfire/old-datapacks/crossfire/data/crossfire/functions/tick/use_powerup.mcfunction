# power-up is an objective set one higher whenever a carrot on a stick is right clicked
# We run the function for all players with a power-up score and then reset the score.
execute as @a[scores={powerup=1..}] run function crossfire:use_powerup2
scoreboard players set @a powerup 0