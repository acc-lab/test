extends "res://assets/scripts/sprite_template.gd"

const full_health = 80
const damage_per_projectile = 30
const sight_range = 450

const AA_delay = 0.33
const post_AA_delay = 1.17

const estimated_reload = AA_delay + post_AA_delay

const cycle_time = 0.42

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "arrow", {
		"position": self.position + Vector2(27*getDir(), -23),
		"team": team,
		"velocity": Vector2(26*getDir(), -1.9),
		"acceleration": Vector2(-0.4*getDir(), 0.2),
		"damage": damage_per_projectile
	})
	
func _ready():
	health = full_health
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur, cycle_time)):
		state = "idle"
		return cycle_time
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
	elif(state == "attack"):
		if Constants.geq(dur, AA_delay):
			#print("shoot!")
			_attack()
			state = "after_attack"
			return AA_delay
	elif(state == "after_attack"):
		if Constants.geq(dur, post_AA_delay):
			state = "idle"
			return post_AA_delay
	
	return 0
