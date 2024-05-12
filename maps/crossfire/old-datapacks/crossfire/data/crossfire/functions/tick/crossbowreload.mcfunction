# Kill all dropped crossbows
execute as @e[type=item,nbt={Item:{id:"minecraft:crossbow"}}] run kill @s
# Kill all power-ups
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] run kill @s
execute as @e[type=item,nbt={Item:{id:"minecraft:potion"}}] run kill @s
execute as @e[type=item,nbt={Item:{id:"minecraft:glass_bottle"}}] run kill @s

# Remove illegal items from your inventory
clear @a[tag=!admin] #crossfire:illegal_items

# Remove pregame/postgame tag if you're spectating and not in the game
tag @a[tag=spectating,tag=!joined] remove postgame
tag @a[tag=spectating,tag=!joined] remove pregame
tag @a[tag=spectating,tag=!joined] add mapchanger

# Take givecrossbow and reloadcrossbow tags from spectators and admins tag @s remove givecrossbow
execute as @a[tag=givecrossbow] unless entity @s[tag=!spectating,tag=!died,tag=!admin] run tag @s remove givecrossbow
execute as @a[tag=reloadcrossbow] unless entity @s[tag=!spectating,tag=!died,tag=!admin] run tag @s remove reloadcrossbow

# Make sure you have the map switch item_tele and item_tele2
execute as @a[tag=mapchanger,scores={map=1},tag=!admin] store result score @s item_tele2 run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:3} 0
execute as @a[tag=mapchanger,scores={map=1},tag=!admin] if score @s item_tele2 matches 2.. run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:3}
execute as @a[tag=mapchanger,scores={map=1},tag=!admin] unless score @s item_tele2 matches 1 run item replace entity @s container.8 with carrot_on_a_stick{CustomModelData:3,display:{Name:"{\"color\":\"dark_green\",\"italic\":false,\"text\":\"Go to the Party map\"}"}} 1

execute as @a[tag=mapchanger,scores={map=0},tag=!admin] store result score @s item_tele run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:2} 0
execute as @a[tag=mapchanger,scores={map=0},tag=!admin] if score @s item_tele matches 2.. run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:2}
execute as @a[tag=mapchanger,scores={map=0},tag=!admin] unless score @s item_tele matches 1 run item replace entity @s container.8 with carrot_on_a_stick{CustomModelData:2,display:{Name:"{\"color\":\"dark_aqua\",\"italic\":false,\"text\":\"Go to the Duel map\"}"}} 1

# If you can't switch maps, you can quit. So we give you the quit item.
execute as @a[tag=!mapchanger,tag=!admin,tag=!postgame,tag=!pregame] store result score @s item_leave run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:4} 0
execute as @a[tag=!mapchanger,tag=!admin,tag=!postgame,tag=!pregame] if score @s item_leave matches 2.. run clear @s[tag=!admin] minecraft:carrot_on_a_stick{CustomModelData:4}
execute as @a[tag=!mapchanger,tag=!admin,tag=!postgame,tag=!pregame] unless score @s item_leave matches 1 run item replace entity @s container.8 with carrot_on_a_stick{CustomModelData:4,display:{Name:"{\"color\":\"red\",\"italic\":false,\"text\":\"Leave Game\"}"}} 1

# Remove slot items in pre/postgame
execute as @a[tag=!admin,tag=postgame] run item replace entity @s[tag=!admin] container.8 with minecraft:air
execute as @a[tag=!admin,tag=pregame] run item replace entity @s[tag=!admin] container.8 with minecraft:air

# Set `item_cross` to the amount of crossbows the player has
# Give or take crossbow if the player should(n't) have it
execute as @a unless entity @s[tag=!spectating,tag=!died,tag=!admin,tag=givecrossbow] run clear @s[tag=!admin] minecraft:crossbow
execute as @a[tag=!spectating,tag=!died,tag=!admin,tag=givecrossbow] store result score @s item_cross run clear @s[tag=!admin] minecraft:crossbow 0
execute as @a[tag=!spectating,tag=!died,tag=!admin,tag=givecrossbow] if score @s item_cross matches 2.. run clear @s[tag=!admin] minecraft:crossbow
execute as @a[tag=!spectating,tag=!died,tag=!admin,tag=givecrossbow] store result score @s item_cross run clear @s[tag=!admin] minecraft:crossbow 0
execute as @a[tag=!spectating,tag=!died,tag=!admin,tag=givecrossbow] if score @s item_cross matches 0 run item replace entity @s container.1 with crossbow{HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Empty Crossbow\",\"color\":\"dark_gray\"}"}} 1

# Determine whether or not the player is currently allowed to reload
execute as @a[tag=!spectating,tag=reloadcrossbow,scores={isreloading=..0,respawnshield=..3},tag=!died,tag=!admin,nbt={SelectedItem:{id:"minecraft:crossbow",tag:{Charged:0b}}}] run scoreboard players set @s isreloading 1
execute as @a[scores={isreloading=1..},tag=!spectating] unless entity @s[tag=reloadcrossbow,scores={respawnshield=..3},tag=!died,tag=!admin,nbt={SelectedItem:{id:"minecraft:crossbow",tag:{Charged:0b}}}] run scoreboard players set @s timer 1
execute as @a[scores={isreloading=1..},tag=!spectating] unless entity @s[tag=reloadcrossbow,scores={respawnshield=..3},tag=!died,tag=!admin,nbt={SelectedItem:{id:"minecraft:crossbow",tag:{Charged:0b}}}] run scoreboard players set @s isreloading 0

# Increase timer
execute as @a[scores={isreloading=1..}] run scoreboard players add @s timer 1
# Increase timer further if you have rapid fire
execute as @a[scores={isreloading=1..},predicate=crossfire:has_rapid_fire] run scoreboard players add @s timer 3

# Give reload crossbows during reloading
execute as @a[tag=givecrossbow,scores={timer=1..10}] run item replace entity @s container.1 with crossbow{CustomModelData:17,HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Reloading Crossbow\",\"color\":\"dark_gray\"}"}} 1
execute as @a[tag=givecrossbow,scores={timer=11..20}] run item replace entity @s container.1 with crossbow{CustomModelData:18,HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Reloading Crossbow.\",\"color\":\"dark_gray\"}"}} 1
execute as @a[tag=givecrossbow,scores={timer=21..30}] run item replace entity @s container.1 with crossbow{CustomModelData:19,HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Reloading Crossbow..\",\"color\":\"dark_gray\"}"}} 1
execute as @a[tag=givecrossbow,scores={timer=31..40}] run item replace entity @s container.1 with crossbow{CustomModelData:20,HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Reloading Crossbow...\",\"color\":\"dark_gray\"}"}} 1

# Reload if we may
execute as @a[tag=givecrossbow,tag=!spectating,tag=!died,predicate=!crossfire:has_multishot] at @s run execute as @s if score @s timer matches 40.. run function crossfire:give_crossbow
execute as @a[tag=givecrossbow,tag=!spectating,tag=!died,predicate=crossfire:has_multishot] at @s run execute as @s if score @s timer matches 40.. run function crossfire:give_crossbow_multishot