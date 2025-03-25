extends "res://assets/scripts/sprite_template.gd"

const full_health = 120
const damage = 20
const sight_range = 30

const AA_delay = 0.39
const post_AA_delay = 0.24
const pre_delay = 0.06

const estimated_reload = AA_delay + post_AA_delay + pre_delay

const pre_atk_time = 0.24
const cycle_time = 1.26

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(33*getDir(), -45),
		"slide": [self.position + Vector2(40*getDir(), -31), self.position + Vector2(35*getDir(), -23)],
		"team": team,
		"damage": damage,
	})
	
func _ready():
	health = full_health
	.set_health_bar()

func cst_movement(dur):
	if state == "idle":
		state = "walk"
	
	if state == "walk":
		if Constants.geq(dur, cycle_time):
			state = "idle"
			return cycle_time
			
	elif state == "before_attack" and Constants.geq(dur, pre_delay):
		state = "attack"
		return pre_delay
		
	elif state == "attack":
		if Constants.geq(dur, pre_atk_time) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, AA_delay) and phase=="1":
			state = "after_attack"
			phase = ""
			return AA_delay
			
	elif state == "after_attack":
		if Constants.geq(dur, post_AA_delay):
			state = "walk"
			return post_AA_delay
	
	if state == "walk" and exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	return 0
