extends Node2D

onready var money = 0
onready var mps = 10

onready var tick = 0

onready var display = $"money displayer"

func _ready():
	pass

func _process(delta):
	tick += delta
	if tick >= 0.03:
		tick -= 0.03
		
		money += 0.03*mps
		
		display.text = '$'+str(int(money))
		
		
	
