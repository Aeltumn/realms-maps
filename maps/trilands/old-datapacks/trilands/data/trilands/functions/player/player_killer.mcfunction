scoreboard players add @s killgold 50
execute as @s if score @s challenge matches 6 run scoreboard players add @s[tag=!challengefinish] c_progress 50
execute as @s if score @s challenge matches 1 run scoreboard players add @s[tag=!challengefinish] c_progress 1
scoreboard players add @s totalkills 1
scoreboard players add @s roundkills 1
title @s title {"text":" "}
title @s subtitle ["",{"text":"Killed "},{"selector":"@a[tag=died]","color":"gold"}]