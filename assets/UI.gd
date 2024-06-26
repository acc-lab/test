extends Node2D

onready var money = 690
onready var mps = 4

onready var tick = 0

onready var display = $"money displayer"

onready var type = ["", "", "axy", "archer2", "tank", "police", "healer"]
onready var price = [0, 0, 50, 100, 250, 500, 9999999999]

var cooldown = [-1, -1, 1.8, 3.6, 10.8, 21, 999]
var delay = [0, 0, 0, 0, 0, 0, 0]

func _ready():
	delay = cooldown.duplicate()

func _process(delta):
	tick += delta
	if tick >= 0.03:
		tick -= 0.03
		
		money += 0.03*mps
		
		display.text = '$'+str(int(money))
		if display.err == true:
			display.bbcode_text = "[color=red]"+display.text+"[/color]"
		
		for each in range(len(delay)):
			delay[each] += 0.03
			if delay[each] >= cooldown[each]:
				delay[each] = cooldown[each]
		
		
	
