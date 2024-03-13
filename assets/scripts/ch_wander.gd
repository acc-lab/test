extends KinematicBody2D

onready var animator = $animator
onready var sprite = $AnimatedSprite

var uuid
var team = 1
var observe_target_x
var state = "idle"

func _ready():
	self.position.y = 400
	animator.current_animation = "idle"
	
var tick = 0
var last_tick = 0
var last_state

func exceed(a, b, dir):
	if dir > 0: return Constants.gneq(a, b)
	else: return Constants.gneq(b, a)

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		state = "idle"
		return 0.42
	elif(state == "idle"):
		if exceed(self.position.x + 450*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
	elif(state == "attack"):
		if Constants.geq(dur, 0.33):
			#print("shoot!")
			state = "after_attack"
			return 0.33
	elif(state == "after_attack"):
		if Constants.geq(dur, 1.17):
			state = "idle"
			return 1.17
			#print("super idle")
	
	return 0
			
	#print(uuid, " ", state)

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	self.scale.x = 1*getDir()
	if(!animator.current_animation): animator.current_animation = "idle"
	
	var del = cst_movement(dur)
	
	if(state != last_state):
		var anim = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle"}[state]
		animator.current_animation = anim
		last_tick += del
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
