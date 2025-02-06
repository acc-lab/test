extends NinePatchRect

onready var button_manager = $"../button manager"
onready var description = $"text displayer"

func _ready():
	description.bbcode_text = "[color=grey][Select something to view description][/color]"

func _on_button_manager_update_description():
	description.bbcode_text = {
2: """[center]Axeman[/center]

[color=red]Unit Price: 50[/color]
[color=gray]Cooldown: 0.9 sec[/color]

"Did you just assume my gender?"

[color=purple]Axeman is good at tanking minor damages and dealing solid damages.[/color]

[color=#FFC0CB]Health[/color]: 150 units
[color=red]Damage[/color]: 30 units
[color=green]Range[/color]: 30 units
[color=#00FFFF]Reload[/color]: 0.69 sec


Axeman hates the generic look of his and the axe design which looks like a bug net.
""",
3: """[center]Archer[/center]

[color=red]Unit Price: 150[/color]
[color=gray]Cooldown: 1.8 sec[/color]

"Pew pew pew, or whatever sound the bow makes."

[color=purple]Archer is perfect for mid-long range attack, dealing reliable damages.[/color]

[color=#FFC0CB]Health[/color]: 80 units
[color=red]Damage[/color]: 20 units per projectile
[color=green]Range[/color]: 450 units
[color=#00FFFF]Reload[/color]: 1.5 sec


In the earlier versions, the archer would bend the bow's wooden part just to shoot the arrow. Life is hard for the archer.
""",
4: """[center]Meat Shield[/center]

[color=red]Unit Price: 250[/color]
[color=gray]Cooldown: 5.4 sec[/color]

"Ow, that hurts."

[color=purple]It is a meat shield that doesn't deal damage. Simple, no?[/color]

[color=#FFC0CB]Health[/color]: 1825 units
[color=green]Range[/color]: 75 units


Ah yes, meat shield- the character with the most depth ever.
""",
5: """[center]Police[/center]

[color=red]Unit Price: 600[/color]
[color=gray]Cooldown: 10.5 sec[/color]

"I'm OP asf, deploy me."

[color=purple]Shoots 3 bullets that penetrate and deal high damages.[/color]

[color=#FFC0CB]Health[/color]: 300 units
[color=red]Damage[/color]: 200 units per projectile, per penetration
[color=blue]Multishot[/color]: Shoots 3 projectiles
[color=purple]Penetration[/color]: Deals damage to up to 3 entity
[color=green]Range[/color]: 550 units
[color=#00FFFF]Reload[/color]: 21 sec


Not associated or affiliated with the Hong Kong police.
""",
6: """[center]Ninja[/center]

[color=red]Unit Price: 200[/color]
[color=gray]Cooldown: 3.6 sec[/color]

"My attack animation is just me jumping up and down, because why not."

[color=purple]Does quick damage and dashes.[/color]

[color=#FFC0CB]Health[/color]: 300 units
[color=red]Damage[/color]: 10 units
[color=blue]Dash Damage[/color]: 100 units
[color=green]Dash Range[/color]: 220-230 units
[color=#00FFFF]Reload[/color]: 0.24 sec

What? It is not the bandit from CR!
""",
}[button_manager.mode]
