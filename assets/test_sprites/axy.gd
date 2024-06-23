extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "chop", {
		"position": self.position + Vector2(33*getDir(), -45),
		"slide": [self.position + Vector2(40*getDir(), -31), self.position + Vector2(35*getDir(), -23)],
		"team": team,
		"damage": 50,
	})
	
func _ready():
	health = 200
	.set_health_bar()

func cst_movement(dur):
	if state == "idle":
		state = "walk"
	
	if state == "walk":
		if Constants.geq(dur,1.26):
			state = "idle"
			return 1.26
			
	elif state == "before_attack" and Constants.geq(dur, 0.06):
		state = "attack"
		return 0.06
		
	elif state == "attack":
		if Constants.geq(dur, 0.24) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, 0.39) and phase=="1":
			state = "after_attack"
			phase = ""
			return 0.39
			
	elif state == "after_attack":
		if Constants.geq(dur, 0.24):
			state = "walk"
			return 0.24
	
	if state == "walk" and exceed(self.position.x + 30*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	return 0
