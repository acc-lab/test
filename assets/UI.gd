extends Node2D

onready var money = 690
onready var mps = 4

onready var tick = 0

onready var display = $"money displayer"

onready var type = ["", "", "axy", "archer2", "tank", "police", "ninja"]
onready var price = [0, 0, 50, 150, 250, 600, 150]

var cooldown = [-1, -1, 0.9, 1.8, 5.4, 10.5, 3.6]
var delay = [0, 0, 0, 0, 0, 0, 0]

func _ready():
	delay = cooldown.duplicate()

func _process(delta):
	tick += delta
	print(tick)
	if tick >= 0.03:
		
		var tick_passed: int = floor(tick / 0.03)
		
		print(tick_passed)
		
		tick -= 0.03 * tick_passed
		
		money += 0.03 * tick_passed *mps
		
		display.text = '$'+str(int(money))
		if display.err == true:
			display.bbcode_text = "[color=red]"+display.text+"[/color]"
		
		for each in range(len(delay)):
			delay[each] += 0.03 * tick_passed
			if delay[each] >= cooldown[each]:
				delay[each] = cooldown[each]
		
		
	
