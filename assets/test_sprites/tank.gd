extends "res://assets/scripts/sprite_template.gd"

const full_health = 1825
const sight_range = 25

const cycle_time = 0.42

func _attack():
	# custom attack script
	
	pass
	
func _ready():
	health = full_health
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur, cycle_time)):
		state = "idle"
		return cycle_time
		
	elif(state == "idle"):
		if exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
			state = "idle" # attack
		else:
			state = "walk"
		return 0
	
	return 0
