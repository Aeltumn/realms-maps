# Call the correct drop function
execute if entity @s[tag=gold,tag=0] run function crossfire:drop_gold0
execute if entity @s[tag=gold,tag=1] run function crossfire:drop_gold1
execute if entity @s[tag=iron,tag=0] run function crossfire:drop_iron0
execute if entity @s[tag=iron,tag=1] run function crossfire:drop_iron1