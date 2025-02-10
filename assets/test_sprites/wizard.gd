extends "res://assets/scripts/sprite_template.gd"

var atkcnt=0
var volt=-1 #decide throw which ball

func _attack():
	# custom attack script
	var dist = abs(self.position.x-observe_target_x+10)
	
	# review these magic number
	var vx = 150*getDir()*3.0/100.0
	var vy = ((22/max(dist,15)-4*max(dist,15)/900.0))*150*3.0/100.0
	
	
	var ax = 0
	var ay = 8/900.0*(150*150)*3.0/100.0*3.0/100.0
	
	# old: heal, healRange, health, expiringSpeed
	# 0.2, randomize(60, 80), 150, 0.25
	
	emit_signal("_shoot_projectile","wizardball",{
		"position":self.position+Vector2(16*getDir(),-22),
		"team":team,
		"velocity":Vector2(vx, vy),
		"acceleration":Vector2(ax, ay),
		"voltage":volt,
		"attached_to":self,
	})
	volt*=-1
	
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
		if Constants.geq(dur, .24):
			#print("shoot!")
			_attack()
			atkcnt+=1
			if atkcnt==2:
				state = "after_attack"
				atkcnt=0
			return 0.24
	elif(state == "after_attack"):
		if Constants.geq(dur, 3.36):
			state = "idle"
			return 3.36
			#print("super idle")
	
	return 0
