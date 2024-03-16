extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "arrow", {
		"position": self.position + Vector2(16*getDir(), -22),
		"team": team,
		"velocity": Vector2(18*getDir(), -1.8),
		"acceleration": Vector2(0.2*getDir(), 0.2),
		"damage": 100
	})

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
		if Constants.geq(dur, 0.18) and phase=="":
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
	
	if state == "walk" and exceed(self.position.x + 35*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	return 0
