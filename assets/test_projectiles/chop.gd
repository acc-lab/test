extends KinematicBody2D

var uuid
var team = 1
var damage=10

var slide = [] # slide sequence

var tick=0
var last_tick=0

func _ready():
	set_collision_layer(0)
	set_collision_mask((team)%2+1)
	
	self.scale.x = getDir()
	cst_movement()

func cst_movement():
	var s = slide[0] - self.position
	var collision = move_and_collide(s)
	
	if not collision:
		for i in range(len(slide)-1):
			s = slide[i+1] - slide[i]
			collision = move_and_collide(s)
			if collision:
				break
	if collision:
		var collider = collision.collider
		collider.set_damage(damage)
		
	#call_deferred("free")

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
