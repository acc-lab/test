extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -23),
		"team": team,
		"velocity": Vector2(75*getDir(), -1),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": 200
	})
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -22),
		"team": team,
		"velocity": Vector2(75*getDir(), -2),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": 200
	})
	
	emit_signal("_shoot_projectile", "bullet", {
		"position": self.position + Vector2(25*getDir(), -24),
		"team": team,
		"velocity": Vector2(75*getDir(), -3),
		"acceleration": Vector2(0, 0.4),
		"drag_constant": 0.002,
		"damage": 200
	})
	
	$"../..".shake(10.0, 0.5)
	
func _ready():
	health = 300
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		state = "idle"
		return 0.42
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + 550*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
	elif(state == "attack"):
		if Constants.geq(dur, 0.33):
			#print("shoot!")
			_attack()
			state = "after_attack"
			return 0.33
	elif(state == "after_attack"):
		if Constants.geq(dur, 17.67):
			state = "idle"
			return 17.67
			#print("super idle")
	
	return 0
