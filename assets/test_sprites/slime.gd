extends "res://assets/scripts/sprite_template.gd"

const full_health = 90
const damage = 50
const sight_range = 40

const pre_AA_delay = 0.03
const AA_delay = 0.63
const post_AA_delay = 0.03

const estimated_reload = pre_AA_delay + AA_delay + post_AA_delay

const cycle_time = 0.9

func _attack():
	# custom attack script
	
	# insert a particle here
	# ManagerParticle.emit_particle("ninjaDash",self.position + Vector2(24*getDir(), -20))
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(0*getDir(), -22),
		"slide": [self.position + Vector2(40*getDir(), -22)],
		"team": team,
		"damage": damage,
	})
	
	SFX.play_sound("Tear")
	
func _ready():
	health = full_health
	.set_health_bar()
	
	$'health bar'.rect_position.y = -36

func cst_movement(dur):
	if state == "walk":
		if Constants.geq(dur, cycle_time):
			state = "idle"
			return cycle_time
			
	elif state == "before_attack" and Constants.geq(dur, pre_AA_delay):
		state = "attack"
		return pre_AA_delay
		
	elif state == "attack":
		if Constants.geq(dur, AA_delay):
			state = "after_attack"
			phase = ""
			return AA_delay
			
	elif state == "after_attack":
		if Constants.geq(dur, post_AA_delay):
			state = "idle"
			return post_AA_delay
	
	if state == "idle" and exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
		state = "before_attack"
			
	elif state == "idle":
		state = "walk"
		
		return Constants.to30msmul(dur)
	
	return 0

func death_animation():
	pass
	# ManagerParticle.emit_particle("chickenDeath", self.position)
