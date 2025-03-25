extends NinePatchRect

onready var button_manager = $"../button manager"
onready var description = $"text displayer"

func _ready():
	description.bbcode_text = "[color=grey][Select something to view description][/color]"

func _on_button_manager_update_description():
	description.bbcode_text = {
2: """[center]Axy[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"I swing axe and stuff"

[color=purple]Tanks and deals solid damage.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage} units
[color=green]Range[/color]: {range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[2],
	"cd": TileLib.cooldown[2],
	"health": Preloads.method["axy"].full_health,
	"damage": Preloads.method["axy"].damage,
	"range": Preloads.method["axy"].sight_range,
	"reload": Preloads.method["axy"].estimated_reload,
}),
3: """[center]Archer[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Pew pew pew, or whatever sound the bow makes"

[color=purple]Perfect for mid range, dealing reliable damage.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage_per_projectile} units per projectile
[color=green]Range[/color]: {range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[3],
	"cd": TileLib.cooldown[3],
	"health": Preloads.method["archer2"].full_health,
	"damage_per_projectile": Preloads.method["archer2"].damage_per_projectile,
	"range": Preloads.method["archer2"].sight_range,
	"reload": Preloads.method["archer2"].estimated_reload,
}),
4: """[center]Tank[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Ow, that hurts"

[color=purple]A meat shield; doesn't attack.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=green]Range[/color]: {range} units
""".format({
	"price": TileLib.price[4],
	"cd": TileLib.cooldown[4],
	"health": Preloads.method["tank"].full_health,
	"range": Preloads.method["tank"].sight_range,
}),
5: """[center]Police[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Pew pew pew, I'm OP"

[color=purple]Shoots {projectiles} bullets that penetrate and deal high damages.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage_per_projectile} units per projectile, per penetration
[color=blue]Multishot[/color]: Shoots {projectiles} projectiles
[color=purple]Penetration[/color]: Deals damage to up to {piercing} entities
[color=green]Range[/color]: {range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[5],
	"cd": TileLib.cooldown[5],
	"health": Preloads.method["police"].full_health,
	"damage_per_projectile": Preloads.method["police"].damage_per_projectile,
	"projectiles": Preloads.method["police"].projectiles,
	"piercing": Preloads.method["police"].piercing,
	"range": Preloads.method["police"].sight_range,
	"reload": Preloads.method["police"].estimated_reload,
}),
6: """[center]Ninja[/center]

[color=red]Unit Price: {price} [/color]
[color=gray]Cooldown: {cd} sec[/color]

"My attack animation is just me jumping up and down, because why not"

[color=purple]Does quick damage and dashes. Cannot hit lower hitbox![/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage} units
[color=blue]Dash Damage[/color]: {dash_damage} units
[color=green]Range[/color]: {range} units
[color=purple]Dash Range[/color]: {dash_range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[6],
	"cd": TileLib.cooldown[6],
	"health": Preloads.method["ninja"].full_health,
	"damage": Preloads.method["ninja"].damage,
	"dash_damage": Preloads.method["ninja"].dash_damage,
	"range": Preloads.method["ninja"].sight_range,
	"dash_range": Preloads.method["ninja"].dash_range,
	"reload": Preloads.method["ninja"].estimated_reload,
}),
7: """[center]Healer[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Something more creative here"

[color=purple]Heals troops.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Healing[/color]: {healing} units
[color=purple]Heal Capacity[/color]: Heals up to {heal_cap} entities
[color=green]Heal Radius[/color]: {heal_rad} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[7],
	"cd": TileLib.cooldown[7],
	"health": Preloads.method["healer"].full_health,
	"healing": Preloads.method["healer"].healing,
	"heal_cap": Preloads.method["healer"].heal_capacity,
	"heal_rad": Preloads.method["healer"].heal_radius,
	"reload": Preloads.method["healer"].estimated_reload,
}),
8: """[center]Chicken[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Valley chicken gone wild"

[color=purple]Short hitbox, low HP but very quick.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage} units
[color=green]Range[/color]: {range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[8],
	"cd": TileLib.cooldown[8],
	"health": Preloads.method["chicken"].full_health,
	"damage": Preloads.method["chicken"].damage,
	"range": Preloads.method["chicken"].sight_range,
	"reload": Preloads.method["chicken"].estimated_reload,
}),
9: """[center]Slime[/center]

[color=red]Unit Price: {price}[/color]
[color=gray]Cooldown: {cd} sec[/color]

"Terrain slime gone wild"

[color=purple]Flexible hitbox with consistent damage.[/color]

[color=#FFC0CB]Health[/color]: {health} units
[color=red]Damage[/color]: {damage} units
[color=green]Range[/color]: {range} units
[color=#00FFFF]Reload[/color]: {reload} sec
""".format({
	"price": TileLib.price[9],
	"cd": TileLib.cooldown[9],
	"health": Preloads.method["slime"].full_health,
	"damage": Preloads.method["slime"].damage,
	"range": Preloads.method["slime"].sight_range,
	"reload": Preloads.method["slime"].estimated_reload,
}),
}[button_manager.mode]
