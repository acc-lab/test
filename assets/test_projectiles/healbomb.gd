extends KinematicBody2D

var uuid
var team = 1
var vx
var vy
var ax
var ay

var tick=0
var last_tick=0

var healing=100 #hp

var exploded = false
var time_after_exploding = 0

# var heal_rate=1 #hp/s
# var decay_rate=-1 #-hp/s

var heal_capacity = 3 # person

func _ready():
	set_collision_layer(0)
	set_collision_mask(0)

func cst_movement(dur):
	if dur >= 0.03:
		if exploded:
			time_after_exploding += 0.03
			
			var collision = move_and_collide(Vector2(0,0), true, true, true)
			
			while collision:
				var collider = collision.collider
				
				collider.set_heal(healing)
				add_collision_exception_with(collider)
				
				heal_capacity -= 1
					
				if heal_capacity <= 0:
					call_deferred("free")
					
					break
					
				collision = move_and_collide(Vector2(0,0), true, true, true)
			
			if heal_capacity>0:
				call_deferred("free")
			
		else:
			position += Vector2(vx, vy)
			
			vx+=ax;
			vy+=ay;
			
		return 0.03
	return 0

func _process(delta):
	tick += delta
	var dur = tick - last_tick
	
	var del = cst_movement(dur)
	
	update()
	
	last_tick += del
		
	if(self.position.x > 960*2 or self.position.x < -960):
		call_deferred("free")
	elif(self.position.y < -400):
		call_deferred("free")
		
	if self.position.y >= 400:
		exploded = true
		hide()
		set_collision_mask(team)
			
		$hitbox_beforeExploding.disabled = true
		$hitbox_exploded.disabled = false
		
		
func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction

