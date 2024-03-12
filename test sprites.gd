extends Node2D

var scene = {}
var scenes = ["archer", "axy", "healer", "police", "tank"]

func _ready():
	for name in scenes:
		scene[name] = load("res://assets/test_sprites/{name}.tscn".format({"name":name}))

var rng = RandomNumberGenerator.new()

var ticks = 0

func _process(delta):
	ticks += delta
	
	"""
	if ticks > 1:
		ticks -= 1
		var RI = rng.randi_range(1, 100)
		
		if RI >= 80:
			# instantiate with name scenes[scene_num]
			var sc = scene[scenes[rng.randi_range(0, 4)]]
			
			var instance = sc.instance()
			instance.position.x = -20
			add_child(instance)
	"""
			
