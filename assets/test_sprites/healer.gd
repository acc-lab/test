extends "res://assets/scripts/sprite_template.gd"

func _attack():
	# custom attack script
	#emit_signal("_shoot_projectile","healbomb",{
	#	"position":self.position+Vector2(10*getDir(),-30),
	#	"team":team,
	#	"velocity":Vector2(26,27)
	#})
	
	pass
	
func _ready():
	health = 400 
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		state = "idle"
		return 0.42
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + 700*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
	elif(state == "attack"):
		if Constants.geq(dur, 0.84):
			#print("shoot!")
			_attack()
			state = "after_attack"
			return 0.84
	elif(state == "after_attack"):
		if Constants.geq(dur, 12.36):
			state = "idle"
			return 12.36
			#print("super idle")
	
	return 0
