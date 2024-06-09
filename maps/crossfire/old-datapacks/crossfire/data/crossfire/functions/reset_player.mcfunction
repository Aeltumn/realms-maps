# Don't remove joined when going to postgame to avoid triggering spectator
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s remove joined
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s remove joined

# Give/take postgame
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tag @s add postgame
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tag @s add postgame
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s remove postgame
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s remove postgame

# Allow changing maps if not in post-game
execute if entity @s[scores={map=0}] if score postgametimer0 postgametimer matches -1 run tag @s add mapchanger
execute if entity @s[scores={map=1}] if score postgametimer1 postgametimer matches -1 run tag @s add mapchanger
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tag @s remove mapchanger
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tag @s remove mapchanger

# Teleport player different during post-game
execute if entity @s[scores={map=1}] unless score postgametimer1 postgametimer matches -1 run tp @s[tag=!admin] 529 71 296 -90 0
execute if entity @s[scores={map=0}] unless score postgametimer0 postgametimer matches -1 run tp @s[tag=!admin] 529 72 421 -90 0
