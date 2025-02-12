extends NinePatchRect

onready var button_manager = $"../button manager"
onready var description = $"text displayer"

func _ready():
	description.bbcode_text = "[color=grey][Select something to view description][/color]"

func _on_button_manager_update_description():
	description.bbcode_text = {
2: """[center]Axy[/center]

[color=red]Unit Price: 50[/color]
[color=gray]Cooldown: 0.99 sec[/color]

"The art of SPAM"

[color=purple]Deals solid damage.[/color]

[color=#FFC0CB]Health[/color]: 120 units
[color=red]Damage[/color]: 20 units
[color=green]Range[/color]: 30 units
[color=#00FFFF]Reload[/color]: 0.69 sec
""",
3: """[center]Archer[/center]

[color=red]Unit Price: 150[/color]
[color=gray]Cooldown: 1.89 sec[/color]

"Pew pew pew, or whatever sound the bow makes"

[color=purple]Perfect for mid range, dealing reliable damage.[/color]

[color=#FFC0CB]Health[/color]: 80 units
[color=red]Damage[/color]: 20 units per projectile
[color=green]Range[/color]: 450 units
[color=#00FFFF]Reload[/color]: 1.5 sec
""",
4: """[center]Meat Shield[/center]

[color=red]Unit Price: 250[/color]
[color=gray]Cooldown: 5.4 sec[/color]

"Ow, that hurts"

[color=purple]A meat shield; doesn't attack.[/color]

[color=#FFC0CB]Health[/color]: 1825 units
[color=green]Range[/color]: 75 units
""",
5: """[center]Police[/center]

[color=red]Unit Price: 500[/color]
[color=gray]Cooldown: 9.51 sec[/color]

"I'm OP"

[color=purple]Shoots 3 bullets that penetrate and deal high damages.[/color]

[color=#FFC0CB]Health[/color]: 300 units
[color=red]Damage[/color]: 200 units per projectile, per penetration
[color=blue]Multishot[/color]: Shoots 3 projectiles
[color=purple]Penetration[/color]: Deals damage to up to 3 entities
[color=green]Range[/color]: 550 units
[color=#00FFFF]Reload[/color]: 18 sec
""",
6: """[center]Ninja[/center]

[color=red]Unit Price: 150[/color]
[color=gray]Cooldown: 3.6 sec[/color]

"My attack animation is just me jumping up and down, because why not"

[color=purple]Does quick damage and dashes.[/color]

[color=#FFC0CB]Health[/color]: 500 units
[color=red]Damage[/color]: 20 units
[color=blue]Dash Damage[/color]: 300 units
[color=green]Dash Range[/color]: 220-230 units
[color=#00FFFF]Reload[/color]: 0.24 sec
""",
7: """[center]Healer[/center]

[color=red]Unit Price: 450[/color]
[color=gray]Cooldown: 7.2 sec[/color]

"Something more creative"

[color=purple]Heals troops.[/color]

[color=#FFC0CB]Health[/color]: 400 units
[color=red]Healing[/color]: 150 units
[color=purple]Heal Units[/color]: Heals up to 3 entities
[color=green]Heal Radius[/color]: 70 units
[color=#00FFFF]Reload[/color]: 4.2 sec
""",
8: """[center]Chicken[/center]

[color=red]Unit Price: 25[/color]
[color=gray]Cooldown: 0.9 sec[/color]

"Valley chicken gone wild"

[color=purple]Short hitbox, low HP but very quick.[/color]

[color=#FFC0CB]Health[/color]: 50 units
[color=red]Damage[/color]: 5 units
[color=#00FFFF]Reload[/color]: 0.76 sec
""",
9: """[center]Slime[/center]

[color=red]Unit Price: 75[/color]
[color=gray]Cooldown: 1.8 sec[/color]

"Terrain slime gone wild"

[color=purple]Flexible hitbox with consistent damage.[/color]

[color=#FFC0CB]Health[/color]: 90 units
[color=red]Damage[/color]: 50 units
[color=#00FFFF]Reload[/color]: 0.69 sec
""",
10: """[center]Wizard[/center]

[color=red]Unit Price: ???[/color]
[color=gray]Cooldown: ???[/color]

"Magic"

[color=purple]Throws balls of steel (or any conductor)[/color]
[color=red]Damage[/color] ???
[color=#00FFFF]Reload[/color]: ???

"""
}[button_manager.mode]
