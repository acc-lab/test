extends "res://assets/scripts/sprite_template.gd"

func _attack(type = 0):
	# custom attack script
	
	if type == 0:
		emit_signal("_shoot_projectile", "chop", {
			"position": self.position + Vector2(10*getDir(), -30),
			"slide": [self.position + Vector2(35*getDir(), -30)],
			"team": team,
			"damage": 10,
		})
	
	elif type == 1:
		emit_signal("_shoot_projectile", "chop", {
			"position": self.position + Vector2(10*getDir(), -30),
			"slide": [self.position + Vector2(35*getDir(), -30)],
			"team": team,
			"damage": 100,
		})
	
func _ready():
	health = 450
	.set_health_bar()
	
	anims = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle", "before_attack": "idle",
	"before_dash": "before_dash", "dash": "dash"}

func cst_movement(dur):
	if state == "idle":
		state = "walk"
	
	if state == "walk":
		if Constants.geq(dur,0.27):
			state = "idle"
			return 0.27
			
	elif state == "before_attack" and Constants.geq(dur, 0.06):
		state = "attack"
		return 0.06
		
	elif state == "before_dash" and Constants.geq(dur, 0.21):
		state = "dash"
		return 0.21
		
	elif state == "attack":
		if Constants.geq(dur, 0.12) and phase=="":
			_attack()
			phase = "1"
		if Constants.geq(dur, 0.24) and phase=="1":
			state = "after_attack"
			phase = ""
			return 0.24
			
	elif state == "dash":
		if Constants.geq(dur, 0.12):
			_attack(1)
			state = "after_attack"
			return 0.12
			
	elif state == "after_attack":
		if Constants.geq(dur, 0.24):
			state = "walk"
			return 0.24
	
	if state == "walk" and exceed(self.position.x + 30*getDir(), observe_target_x, getDir()):
		state = "before_attack"
		
		return Constants.to30msmul(dur)
	
	if state == "walk" and within(self.position.x + 220*getDir(), self.position.x + 230*getDir(), observe_target_x, getDir()):
		state = "before_dash"
		
		return Constants.to30msmul(dur)
	
	return 0
