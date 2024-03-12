extends KinematicBody2D

onready var animator = $animator
onready var sprite = $AnimatedSprite

var uuid
var team = 1
var observe_target_x
var state = "idle"

var machine_eps = 1.0 # initial value

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

func geq(a, b):
	return (a >= b - machine_eps)
	
var tick = 0
var last_tick = 0
var last_state

func exceed(a, b, dir):
	if dir > 0: return gneq(a, b)
	else: return gneq(b, a)

func cst_movement(dur):
	if(state == "walk" and geq(dur,0.42)):
		state = "idle"
	elif(state == "idle"):
		if exceed(self.position.x + 450*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
	elif(state == "attack"):
		if geq(dur, 0.33):
			#print("shoot!")
			state = "after_attack"
	elif(state == "after_attack"):
		if geq(dur, 1.17):
			state = "idle"
			#print("super idle")
			
	#print(uuid, " ", state)

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	self.scale.x = 0.5*getDir()
	if(!animator.current_animation): animator.current_animation = "idle"
	
	cst_movement(dur)
	
	if(state != last_state):
		var anim = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle"}[state]
		animator.current_animation = anim
		last_tick = tick
		last_state = state
		
	#if(self.position.x > 920):
	#	self.position.x -= 940

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
	
func _move(steps):
	self.position.x += steps * getDir()
	 

func _on_ax_skeleton_mouse_entered():
	state = "attack"


func _on_ax_skeleton_mouse_exited():
	state = "walk"
