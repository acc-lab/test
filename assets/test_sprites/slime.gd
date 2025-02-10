extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	# insert a particle here
	# ManagerParticle.emit_particle("ninjaDash",self.position + Vector2(24*getDir(), -20))
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(0*getDir(), -22),
		"slide": [self.position + Vector2(40*getDir(), -22)],
		"team": team,
		"damage": 35,
	})
	
func _ready():
	health = 75
	.set_health_bar()
	
	$'health bar'.rect_position.y = -36

func cst_movement(dur):
	if state == "walk":
		if Constants.geq(dur, 0.9):
			state = "idle"
			return 0.9
			
	elif state == "before_attack" and Constants.geq(dur, 0.03):
		state = "attack"
		return 0.03
		
	elif state == "attack":
		if Constants.geq(dur, 0.63):
			state = "after_attack"
			phase = ""
			return 0.63
			
	elif state == "after_attack":
		if Constants.geq(dur, 0.03):
			state = "idle"
			return 0.03
	
	if state == "idle" and exceed(self.position.x + 40*getDir(), observe_target_x, getDir()):
		state = "before_attack"
			
	elif state == "idle":
		state = "walk"
		
		return Constants.to30msmul(dur)
	
	return 0

func death_animation():
	pass
	# ManagerParticle.emit_particle("chickenDeath", self.position)
