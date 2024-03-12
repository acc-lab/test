extends KinematicBody2D

onready var animator = $animator
onready var sprite = $AnimatedSprite

var machine_eps = 1.0 # initial value
var state = "idle"

func _ready():
	self.position.y = 400
	animator.current_animation = "idle"
	
	# process the machine epsilon
	while machine_eps + 1 > 1:
		machine_eps /= 2
	machine_eps *= 2

"""
While I used the machine epsilon, it's worthy to note that the "dur" or "tick" in the _process function
can still accumulate deviation. On the other hand, since the delta time fluctuates, the game logic
(which entirely depends on when AnimationPlayer play animations) is not entirely deterministic. However,
even though animations of AnimationPlayer and the _process mainloop are independent, we can still expect
the _process function delay is globally the same among characters (skeletons) (*right?).
"""

func gneq(a, b):
	return not (a <= b+machine_eps)
	
var tick = 0

var bound_x = 600
var y = 400
var last_tick = 0

func cst_movement(dur):
	if(state == "walk" and gneq(dur,0.42)):
		state = "idle"
		dur -= 0.42
	elif(state == "idle"):
		state = "walk"
	

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	if(!animator.current_animation): animator.current_animation = "idle"
	
	cst_movement(dur)
	
	if(state != animator.current_animation):
		animator.current_animation = state
		last_tick = tick
		
	#if(self.position.x > 920):
	#	self.position.x -= 940
	
	
func _move(steps):
	self.position.x += steps
	 

func _on_ax_skeleton_mouse_entered():
	state = "attack"


func _on_ax_skeleton_mouse_exited():
	state = "walk"
