# Reset you if your round is no longer equal to the current round for your map
scoreboard players add @a map 0
execute as @a[scores={map=0}] unless score @s round = round0 round run function crossfire:reset_player
execute as @a[scores={map=1}] unless score @s round = round1 round run function crossfire:reset_player