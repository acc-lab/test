extends "res://assets/scripts/sprite_template.gd"

const full_health = 300
const sight_range = 550
const damage_per_projectile = 200
const piercing = 3

const projectiles = 3  # 3 projectiles

const AA_delay = 0.33
const post_AA_delay = 17.67

const estimated_reload = AA_delay + post_AA_delay

const cycle_time = 0.42

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -23),
		"team": team,
		"velocity": Vector2(75*getDir(), -1),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": damage_per_projectile,
		"piercing": piercing,
	})
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -22),
		"team": team,
		"velocity": Vector2(75*getDir(), -2),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": damage_per_projectile,
		"piercing": piercing,
	})
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -24),
		"team": team,
		"velocity": Vector2(75*getDir(), -3),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": damage_per_projectile,
		"piercing": piercing,
	})
	
	$"../..".shake(10.0, 0.5)
	SFX.play_sound_random(["Dooz", "Heavy Shot"])
	
func _ready():
	health = full_health
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,cycle_time)):
		state = "idle"
		return cycle_time
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
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
