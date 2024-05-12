# Switch your map value, we set to 2 to prevent it getting set back
execute if score @s cooldown matches 50.. as @s[scores={map=0}] run scoreboard players set @s map 2
execute if score @s cooldown matches 50.. as @s[scores={map=1}] run scoreboard players set @s map 0
execute if score @s cooldown matches 50.. as @s[scores={map=2}] run scoreboard players set @s map 1

# Reset player
execute if score @s cooldown matches 50.. run function crossfire:reset_player

# Restart cooldown
execute if score @s cooldown matches 50.. run scoreboard players set @s cooldown 0