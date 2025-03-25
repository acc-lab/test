extends "res://assets/scripts/sprite_template.gd"

const full_health = 400
const detect_range = 700

const healing = 150
const heal_capacity = 3
const heal_radius = 100

const AA_delay = 0.84
const post_AA_delay = 3.36

const estimated_reload = AA_delay + post_AA_delay

const cycle_time = 0.42


func _attack():
	# custom attack script
	var dist = abs(self.position.x-observe_leading_x)
	
	# review these magic number
	var vx = 150*getDir()*3.0/100.0
	var vy = ((22/max(dist,15)-4*max(dist,15)/900.0))*150*3.0/100.0
	
	
	var ax = 0
	var ay = 8/900.0*(150*150)*3.0/100.0*3.0/100.0
	
	# old: heal, healRange, health, expiringSpeed
	# 0.2, randomize(60, 80), 150, 0.25
	
	emit_signal("_shoot_projectile","healbomb",{
		"position":self.position+Vector2(16*getDir(),-22),
		"team":team,
		"velocity":Vector2(vx, vy),
		"acceleration":Vector2(ax, ay),
		"healing": healing,
		"heal_capacity": heal_capacity,
		"heal_radius": heal_radius,
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
		if exceed(self.position.x + detect_range*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
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
			#print("super idle")
	
	return 0
