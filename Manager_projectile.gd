extends Node

var scene = {}
var scenes = ["arrow"]

func _ready():
	for name in scenes:
		scene[name] = load("res://assets/test_projectiles/{name}.tscn".format({"name":name}))

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0
	
func spawn_random():
	if ticks > 0.1:
		ticks -= 0.1
		var RI = rng.randi_range(1, 100)
		
		if RI >= 5:
			# instantiate with name scenes[scene_num]
			var sc = scene[scenes[0]]
			
			var instance = sc.instance()
			instance.set("uuid", UUID)
			instance.position.x = -20
			instance.set("team", 1)
			instance.set("vx", rng.randi_range(15, 35))
			
			UUID += 1
			add_child(instance)
			
			var instance2 = sc.instance()
			instance2.set("uuid", UUID)
			instance2.set("team", 2)
			instance2.set("vx", rng.randi_range(-35, -15))
			
			UUID += 1
			add_child(instance2)

func _process(delta):
	ticks += delta
	
	spawn_random()
	
	var children = get_children()
	
	#print(len(children))
	
	#for i in children: print(i.position.x)
	
	
	
