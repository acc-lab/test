extends "res://assets/scripts/sprite_template.gd"

const full_health = 500
const damage = 20
const dash_damage = 300

const sight_range = 30
const dash_range = [220, 230]

const cycle_time = 0.27

const pre_AA_delay = 0.06
const AA_delay = 0.24
const post_AA_delay = 0.24

const estimated_reload = pre_AA_delay + AA_delay + post_AA_delay

const pre_dash_delay = 0.21
const dash_time = 0.12
const post_dash_delay = 0.12

func _attack(type = 0):
	# custom attack script
	
	if type == 0:
		# attack particles
		ManagerParticle.emit_particle("ninjaDash",self.position+Vector2(0,-30),getDir())
		
		emit_signal("_shoot_projectile", "chop", {
			"position": self.position + Vector2(10*getDir(), -30),
			"slide": [self.position + Vector2(35*getDir(), -30)],
			"team": team,
			"damage": damage,
		})
	
	elif type == 1:
		
		$"../..".shake(5.0, 0.2)
		
		# dash particles (on ground)
		ManagerParticle.emit_particle("ninjaDash",self.position+Vector2(0,-10),getDir())
		
		emit_signal("_shoot_projectile", "chop", {
			"position": self.position + Vector2(10*getDir(), -30),
			"slide": [self.position + Vector2(35*getDir(), -30)],
			"team": team,
			"damage": dash_damage,
		})
	
func _ready():
	health = full_health
	.set_health_bar()
	
	anims = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle", "before_attack": "idle",
	"before_dash": "before_dash", "dash": "dash"}

func cst_movement(dur):
	if state == "idle":
		state = "walk"
	
	if state == "walk":
		if Constants.geq(dur,cycle_time):
			state = "idle"
			return cycle_time
			
	elif state == "before_attack" and Constants.geq(dur, pre_AA_delay):
		state = "attack"
		return pre_AA_delay
		
	elif state == "before_dash" and Constants.geq(dur, pre_dash_delay):
		state = "dash"
		return pre_dash_delay
		
	elif state == "attack":
		if Constants.geq(dur, dash_time) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, AA_delay) and phase=="1":
			state = "after_attack"
			phase = ""
			return AA_delay
			
	elif state == "dash":
		if Constants.geq(dur, post_dash_delay):
			_attack(1)
			state = "after_attack"
			return post_dash_delay
			
	elif state == "after_attack":
		if Constants.geq(dur, post_AA_delay):
			state = "walk"
			return post_AA_delay
	
	if state == "walk" and exceed(self.position.x + sight_range*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	if state == "walk" and within(self.position.x + dash_range[0]*getDir(), self.position.x + dash_range[1]*getDir(), observe_target_x, getDir()):
		state = "before_dash"
		
		return Constants.to30msmul(dur)
	
	return 0
