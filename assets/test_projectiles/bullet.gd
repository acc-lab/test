extends KinematicBody2D

var uuid
var team = 1
var vx=18
var vy=-0.1
var ax=0
var ay=0.5
var drag_const = 0.002
var damage=100

var tick=0
var last_tick=0

var piercing = 1
var pierced = []

func _ready():
	set_collision_layer(0)
	set_collision_mask((team)%2+1)

func cst_movement(dur):
	if dur >= 0.03:
		var target_position = position + Vector2(vx, vy)
		
		var collision = move_and_collide(Vector2(vx, vy))
		
		if collision:
			var collider = collision.collider
			
			if(!pierced.has(collider.get_parent().uuid)):
				collider.set_damage(damage)
				pierced.push_back(collider.get_parent().uuid)
				
				if len(pierced) >= piercing + 1:
					call_deferred("free")
					
			position = target_position
			
		var sp = sqrt(vx*vx+vy*vy)
			
		vx+=ax-vx*sp*drag_const
		vy+=ay-vy*sp*drag_const
		
		return 0.03
	return 0

func _draw():
	draw_line(Vector2(0, 0), Vector2(vx, vy), Color(0.5, 0.5, 0.5), 1)
	
func _process(delta):
	tick += delta
	var dur = tick - last_tick
	
	var del = cst_movement(dur)
	
	update()
	
	last_tick += del
		
	#if(self.position.x > 920):
	#	self.position.x -= 940

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
