extends "res://assets/scripts/sprite_template.gd"

var atkcnt=0
var charge=-20000 #total damage per ball can deal (also affect dps)
var bound_ball
func _attack():
	# custom attack script
	var dist = abs(self.position.x-observe_target_x+10)
	
	# review these magic number
	var vx = 100 - 30 * atkcnt
	var vy = -5+10*atkcnt 


	var ax = getDir()*-2*(.5-atkcnt)
	var ay = .7-1.4*atkcnt
	
	# old: heal, healRange, health, expiringSpeed
	# 0.2, randomize(60, 80), 150, 0.25
	if atkcnt==0:
		bound_ball=null
	
	#print(bound_ball)
	emit_signal("_shoot_projectile","wizardball",{
		"position":self.position+Vector2(16*getDir(),-18),
		"team":team,
		"velocity":Vector2(vx, vy),
		"acceleration":Vector2(ax, ay),
		"charge":charge,
		"attached_to":bound_ball,
		"caller":self,
	})
	
	charge*=-1
	
	pass
	
func _ready():
	health = 400 
	.set_health_bar()

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		atkcnt=0
		state = "idle"
		return 0.42
	elif(state == "idle"):
		atkcnt=0
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + 700*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
	elif(state == "attack"):
		if Constants.geq(dur, .42):
			#print("shoot!")
			_attack()
			atkcnt+=1
			if atkcnt==2:
				state = "after_attack"
				atkcnt=0
			return 0.42
	elif(state == "after_attack"):
		atkcnt=0
		if Constants.geq(dur, 7.26):
			state = "idle"
			return 7.26
			#print("super idle")
	
	return 0
