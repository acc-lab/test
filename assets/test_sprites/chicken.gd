extends "res://assets/scripts/sprite_template.gd"

const full_health = 50
const damage = 5
const sight_range = 30

const pre_AA_delay = 0.03
const AA_delay = 0.3
const post_AA_delay = 0.03

const estimated_reload = pre_AA_delay + AA_delay + post_AA_delay

const atk_time = 0.12

const cycle_time = 0.48


func _attack():
	# custom attack script
	
	# insert a particle here
	# ManagerParticle.emit_particle("ninjaDash",self.position + Vector2(24*getDir(), -20))
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(4*getDir(), -22),
		"slide": [self.position + Vector2(36*getDir(), -22)],
		"team": team,
		"damage": damage,
	})
	
func _ready():
	health = full_health
	.set_health_bar()
	
	$'health bar'.rect_position.y = -46
	
	SFX.play_sound_random(["Chicken", "Chicken 2", "Chicken 3"])

func cst_movement(dur):
	if state == "walk":
		if Constants.geq(dur, cycle_time):
			state = "idle"
			return cycle_time
			
	elif state == "idle":
		state = "walk"
			
	elif state == "before_attack" and Constants.geq(dur, pre_AA_delay):
		state = "attack"
		return pre_AA_delay
		
	elif state == "attack":
		if Constants.geq(dur, atk_time) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, AA_delay) and phase=="1":
			state = "after_attack"
			phase = ""
			return AA_delay
			
	elif state == "after_attack":
		if Constants.geq(dur, post_AA_delay):
			state = "idle"
			return post_AA_delay
	
	if state == "walk" and exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	return 0

func death_animation():
	ManagerParticle.emit_particle("chickenDeath", self.position)
	SFX.play_sound_random(["Splat"])
