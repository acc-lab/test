extends Node

var machine_eps = 1.0 # initial value

"""
While I used the machine epsilon, it's worthy to note that the "dur" or "tick" in the _process function
can still accumulate deviation. On the other hand, since the delta time fluctuates, the game logic
(which entirely depends on when AnimationPlayer play animations) is not entirely deterministic. However,
even though animations of AnimationPlayer and the _process mainloop are independent, we can still expect
the _process function delay is globally the same among characters (skeletons) (*right?).
"""

var scene = {}
var variants = ["archer2", "axy", "healer", "police", "tank"]

func _ready():
	# process the machine epsilon
	while machine_eps + 1 > 1:
		machine_eps /= 2
	machine_eps *= 2
	
	for name in variants:
		scene[name] = load("res://assets/test_sprites/{name}.tscn".format({"name":name}))
	
	scene["sprite_template"] = load("res://assets/sprite_template.tscn")
	
func gneq(a, b):
	return not (a <= b+machine_eps)

func geq(a, b):
	return (a >= b-machine_eps)
