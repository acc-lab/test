extends Node

var scene = {}
var scenes = ["arrow", "chop"]

func _ready():
	for name in scenes:
		scene[name] = load("res://assets/test_projectiles/{name}.tscn".format({"name":name}))

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0

func _process(delta):
	ticks += delta
	
	var children = get_children()
	
	#print(len(children))
	
	#for i in children: print(i.position.x)
	

func _shoot_projectile(type, arguments):
	if type == "arrow":
		var sc = scene[scenes[0]]
		
		var instance = sc.instance()
		instance.set("uuid", UUID)
		instance.set("position", arguments["position"])
		instance.set("team", arguments["team"])
		instance.set("vx", arguments["velocity"].x)
		instance.set("vy", arguments["velocity"].y)
		instance.set("ax", arguments["acceleration"].x)
		instance.set("ay", arguments["acceleration"].y)
		instance.set("damage", arguments["damage"])
		
		UUID += 1
		add_child(instance)
		
	if type == "chop":
		var sc = scene[scenes[1]]
		
		var instance = sc.instance()
		instance.set("uuid", UUID)
		instance.set("position", arguments["position"])
		instance.set("team", arguments["team"])
		instance.set("damage", arguments["damage"])
		
		instance.set("slide", arguments["slide"])
		
		UUID += 1
		add_child(instance)
