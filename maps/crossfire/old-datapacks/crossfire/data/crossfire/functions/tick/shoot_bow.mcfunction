# crossbow is an objective set one higher whenever a crossbow is actually fired
# We run the function for all players with a crossbow score and then reset the score.
execute as @a[scores={crossbow=1..}] run function crossfire:shoot_bow2
scoreboard players set @a crossbow 0