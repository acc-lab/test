extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	# insert a particle here
	# ManagerParticle.emit_particle("ninjaDash",self.position + Vector2(24*getDir(), -20))
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(4*getDir(), -22),
		"slide": [self.position + Vector2(36*getDir(), -22)],
		"team": team,
		"damage": 5,
	})
	
func _ready():
	health = 50
	.set_health_bar()

func cst_movement(dur):
	if state == "walk":
		if Constants.geq(dur,0.6):
			return 0.6
			
	if state == "idle":
		state = "walk"
			
	elif state == "before_attack" and Constants.geq(dur, 0.03):
		state = "attack"
		return 0.03
		
	elif state == "attack":
		if Constants.geq(dur, 0.12) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, 0.3) and phase=="1":
			state = "after_attack"
			phase = ""
			return 0.3
			
	elif state == "after_attack":
		if Constants.geq(dur, 0.03):
			state = "idle"
			return 0.03
	
	if state == "walk" and exceed(self.position.x + 30*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	return 0

func death_animation():
	ManagerParticle.emit_particle("chickenDeath", self.position)
