extends Node2D

onready var money = 400 * $"..".difficulty
onready var mps = 4

onready var tick = 0

onready var display = $"money displayer"

onready var type = ["", "", "axy", "archer2", "tank", "police", "ninja", "healer", "chicken", "slime"]
onready var price = [0, 0, 50, 150, 250, 500, 150, 450, 25, 75]

var cooldown = [-1, -1, 0.99, 1.89, 5.4, 9.51, 3.6, 7.2, 0.9, 1.8]
var delay = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func _ready():
	delay = cooldown.duplicate()
	
	if $"..".debug:
		for i in range(len(cooldown)):
			cooldown[i] = 0.01

func _process(delta):
	tick += delta
	if tick >= 0.03:
		
		var tick_passed: int = floor(tick / 0.03)
		
		tick -= 0.03 * tick_passed
		
		money += 0.03 * tick_passed *mps
		
		display.text = '$'+str(int(money))
		if display.err == true:
			display.bbcode_text = "[color=red]"+display.text+"[/color]"
		
		for each in range(len(delay)):
			delay[each] += 0.03 * tick_passed
			if delay[each] >= cooldown[each]:
				delay[each] = cooldown[each]
		
		
	
