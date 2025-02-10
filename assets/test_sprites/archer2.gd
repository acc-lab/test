extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	
	emit_signal("_shoot_projectile", "arrow", {
		"position": self.position + Vector2(27*getDir(), -23),
		"team": team,
		"velocity": Vector2(26*getDir(), -1.9),
		"acceleration": Vector2(-0.4*getDir(), 0.2),
		"damage": 20
	})
	
func _ready():
	health = 80
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		state = "idle"
		return 0.42
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + 450*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
	elif(state == "attack"):
		if Constants.geq(dur, 0.33):
			#print("shoot!")
			_attack()
			state = "after_attack"
			return 0.33
	elif(state == "after_attack"):
		if Constants.geq(dur, 1.17):
			state = "idle"
			return 1.17
			#print("super idle")
	
	return 0
