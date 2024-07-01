extends NinePatchRect

onready var button_manager = $"../button manager"
onready var description = $"text displayer"

func _ready():
	description.bbcode_text = "[color=grey][Select something to view description][/color]"

func _on_button_manager_update_description():
	description.bbcode_text = {
2: """Axeman
[color=red]Unit Price: 30[/color]

"Did you just assume my gender?"

[color=purple]Axeman is good at tanking minor damages and dealing solid damages.[/color]

[color=#FFC0CB]Health[/color]: 200 units
[color=red]Damage[/color]: 30 units
[color=green]Range[/color]: 30 units
[color=#00FFFF]Reload[/color]: 0.69 sec


[color=#D3D3D3]Insert some lore here.[/color]
""",
3: """Archer
[color=red]Unit Price: 100[/color]

"Pew pew pew, or whatever sound the bow makes."

[color=purple]Archer is perfect for mid-long range attack, dealing relilable damages.[/color]

[color=#FFC0CB]Health[/color]: 80 units
[color=red]Damage[/color]: 25 units per projectile
[color=green]Range[/color]: 450 units
[color=#00FFFF]Reload[/color]: 1.5 sec


[color=#D3D3D3]Insert some lore here.[/color]
""",
4: """Meat Shield
[color=red]Unit Price: 250[/color]

"Ow, that hurts."

[color=purple]It is a meat shield that doesn't deal damage. Simple, no?[/color]

[color=#FFC0CB]Health[/color]: 1300 units
[color=green]Range[/color]: 75 units


[color=#D3D3D3]Insert some lore here.[/color]
""",
5: """Police
[color=red]Unit Price: 500[/color]

"I'm OP asf, deploy me."

[color=purple]Shoots 3 bullets that penetrate and deal high damages.[/color]

[color=#FFC0CB]Health[/color]: 300 units
[color=red]Damage[/color]: 300 units per projectile, per penetration
[color=blue]Multishot[/color]: Shoots 3 projectiles
[color=purple]Penetration[/color]: Deals damage to up to 2 entity
[color=green]Range[/color]: 550 units
[color=#00FFFF]Reload[/color]: 14.07 secs


[color=#D3D3D3]Insert some lore here.[/color]
""",
6: """Coming Soon
[color=red]Unit Price: ???[/color]

"I mean, it is under construction. What am I suppose to write here?"

[color=purple]Does something, probably.[/color]
""",
}[button_manager.mode]
