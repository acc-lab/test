extends NinePatchRect

onready var button_manager = $"../button manager"
onready var description = $"text displayer"

func _ready():
	description.bbcode_text = "[color=grey][Select something to view description][/color]"

func _on_button_manager_update_description():
	description.bbcode_text = {
2: """[center]Axeman[/center]

[color=red]Unit Price: 50[/color]
[color=gray]Cooldown: 1.8 sec[/color]

"Did you just assume my gender?"

[color=purple]Axeman is good at tanking minor damages and dealing solid damages.[/color]

[color=#FFC0CB]Health[/color]: 150 units
[color=red]Damage[/color]: 25 units
[color=green]Range[/color]: 30 units
[color=#00FFFF]Reload[/color]: 0.69 sec


[color=#D3D3D3]Insert some lore here.[/color]
""",
3: """[center]Archer[/center]

[color=red]Unit Price: 100[/color]
[color=gray]Cooldown: 3.6 sec[/color]

"Pew pew pew, or whatever sound the bow makes."

[color=purple]Archer is perfect for mid-long range attack, dealing reliable damages.[/color]

[color=#FFC0CB]Health[/color]: 80 units
[color=red]Damage[/color]: 25 units per projectile
[color=green]Range[/color]: 450 units
[color=#00FFFF]Reload[/color]: 1.5 sec


[color=#D3D3D3]Insert some lore here.[/color]
""",
4: """[center]Meat Shield[/center]

[color=red]Unit Price: 250[/color]
[color=gray]Cooldown: 10.8 sec[/color]

"Ow, that hurts."

[color=purple]It is a meat shield that doesn't deal damage. Simple, no?[/color]

[color=#FFC0CB]Health[/color]: 1800 units
[color=green]Range[/color]: 75 units


[color=#D3D3D3]Insert some lore here.[/color]
""",
5: """[center]Police[/center]

[color=red]Unit Price: 500[/color]
[color=gray]Cooldown: 21 sec[/color]

"I'm OP asf, deploy me."

[color=purple]Shoots 3 bullets that penetrate and deal high damages.[/color]

[color=#FFC0CB]Health[/color]: 300 units
[color=red]Damage[/color]: 300 units per projectile, per penetration
[color=blue]Multishot[/color]: Shoots 3 projectiles
[color=purple]Penetration[/color]: Deals damage to up to 2 entity
[color=green]Range[/color]: 550 units
[color=#00FFFF]Reload[/color]: 14.07 sec


[color=#D3D3D3]Insert some lore here.[/color]
""",
6: """[center]Coming Soon[/center]

[color=red]Unit Price: ???[/color]
[color=gray]Cooldown: ???[/color]

"I mean, it is under construction. What am I suppose to write here?"

[color=purple]Does something, probably.[/color]
""",
}[button_manager.mode]
