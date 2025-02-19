extends KinematicBody2D

var uuid
var team = 1
var vx=18
var vy=-0.1
var ax=0
var ay=0.5
var damage=100

var tick=0
var last_tick=0

func _ready():
	set_collision_layer(0)
	set_collision_mask((team)%2+1)

func cst_movement(dur):
	if dur >= 0.03:
		var collision = move_and_collide(Vector2(vx, vy))
		if collision:
			var collider = collision.collider
			ManagerParticle.emit_particle("arrowHit",collision.position)
			ManagerParticle.emit_particle("blood",collision.position)
			collider.set_damage(damage)
			
			call_deferred("free")
			
		vx+=ax;
		vy+=ay;
		
		return 0.03
	return 0

func _process(delta):
	tick += delta
	var dur = tick - last_tick
	
	
	self.rotation_degrees = atan2(vy, vx)*180/PI
	
	var del = cst_movement(dur)
	
	last_tick += del
		
	if(self.position.x > 960*2 or self.position.x < -960):
		call_deferred("free")
	elif(self.position.y > 400 or self.position.y < -400):
		call_deferred("free")

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
