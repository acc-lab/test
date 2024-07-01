extends Node2D

onready var money = 690
onready var mps = 4

onready var tick = 0

onready var display = $"money displayer"

onready var type = ["", "", "axy", "archer2", "tank", "police", "healer"]
onready var price = [0, 0, 30, 100, 250, 500, 9999999999]

func _ready():
	pass
	#Engine.set_time_scale(2)

func _process(delta):
	tick += delta
	if tick >= 0.03:
		tick -= 0.03
		
		money += 0.03*mps
		
		display.text = '$'+str(int(money))
		if display.err == true:
			display.bbcode_text = "[color=red]"+display.text+"[/color]"
		
		
	
