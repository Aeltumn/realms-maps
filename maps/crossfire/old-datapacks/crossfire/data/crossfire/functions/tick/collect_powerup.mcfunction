# For any dropped item make it get picked up if someone gets nearby
# Only allow collecting by players in active games
execute if score started0 started matches 1 as @e[tag=drop,tag=0] at @s if entity @a[tag=selected0,distance=..1.5,nbt=!{Inventory:[{Slot:4b},{Slot:5b},{Slot:3b}]}] run function crossfire:generated/collect_powerup2
execute if score started1 started matches 1 as @e[tag=drop,tag=1] at @s if entity @a[tag=selected1,distance=..1.5,nbt=!{Inventory:[{Slot:4b},{Slot:5b},{Slot:3b}]}] run function crossfire:generated/collect_powerup2