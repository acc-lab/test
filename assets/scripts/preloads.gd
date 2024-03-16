extends Node

var scene = {}
var method = {}
var variants = ["archer2", "axy", "healer", "police", "tank"]

func _ready():
	for name in variants:
		scene[name] = load("res://assets/test_sprites/{name}.tscn".format({"name":name}))
		method[name] = load("res://assets/test_sprites/{name}.gd".format({"name":name}))
	
	scene["sprite_template"] = load("res://assets/sprite_template.tscn")
	
func gneq(a, b):
	return not (a <= b+Constants.machine_eps)

func geq(a, b):
	return (a >= b-Constants.machine_eps)
