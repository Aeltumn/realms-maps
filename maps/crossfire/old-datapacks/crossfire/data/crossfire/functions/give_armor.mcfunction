# Red armor
execute if entity @s[team=red] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:14352389},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=red] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:14352389},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=red] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:14352389},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Green armor
execute if entity @s[team=green] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:1572623},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=green] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:1572623},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=green] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:1572623},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Blue armor
execute if entity @s[team=blue] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:1363455},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=blue] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:1363455},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=blue] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:1363455},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Yellow armor
execute if entity @s[team=yellow] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:16770580},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=yellow] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:16770580},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=yellow] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:16770580},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Orange armor
execute if entity @s[team=orange] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:16082432},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=orange] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:16082432},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=orange] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:16082432},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Magenta armor
execute if entity @s[team=magenta] run item replace entity @s armor.chest with minecraft:leather_chestplate{display:{color:14549237},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=magenta] run item replace entity @s armor.legs with minecraft:leather_leggings{display:{color:14549237},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}
execute if entity @s[team=magenta] run item replace entity @s armor.feet with minecraft:leather_boots{display:{color:14549237},Enchantments:[{id:"minecraft:binding_curse",lvl:1}],HideFlags:1,Unbreakable:1}

# Remove armor if teamless
execute if entity @s[team=!red,team=!yellow,team=!green,team=!blue,team=!orange,team=!magenta] run clear @s minecraft:leather_chestplate
execute if entity @s[team=!red,team=!yellow,team=!green,team=!blue,team=!orange,team=!magenta] run clear @s minecraft:leather_leggings
execute if entity @s[team=!red,team=!yellow,team=!green,team=!blue,team=!orange,team=!magenta] run clear @s minecraft:leather_boots