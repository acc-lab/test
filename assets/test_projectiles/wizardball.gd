extends Area2D


var uuid
var team = 1
var vx
var vy
var ax
var ay

var charge #determine dps and shown sprite (1 charge = 1 dmg)
var base_conductivity=1 #base conductivity for all objects (this ensure base dps)
var conductivity_factor=100 #factor that was divide by health (the higher this number, the higher dps)
#var resistance=0.001 #only affect dps when at contact, not total damage can be dealt (dps = (charge remain)/(resistance*distance between 2 balls))

var attached_to
var is_paired=false #is_paired is only one way, which means if another ball pair this ball, this would not change
var attachpos #if attached to other ball, then this stores the position of the paired ball, else the position of itself

var to_local 

var tick=0
var last_tick=0


func get_pair_information():
	is_paired=is_instance_valid(attached_to)
	if is_paired:
		attachpos=attached_to.global_position
	else:
		attachpos=global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	get_pair_information()
	$conductor.shape=SegmentShape2D.new()
	$conductor.shape.a=Vector2(0,0)
	#print(is_instance_valid(attached_to))

	if charge>0:
		$ball.play("positive")
	else:
		$ball.play("negative")
	set_collision_layer(0)
	set_collision_mask(3-team)

func cst_movement(dur):
	if dur >= 0.03:
		position += Vector2(vx, vy)*.03
		
		vx+=ax*.03
		vy+=ay*.03
		

		if !is_paired:
			return 0.03
		#var collision = move_and_collide(Vector2(0,0), true, true, true)

		var collidelist= get_overlapping_areas()
		var n=len(collidelist)
		if n==0:
			return 0.03

		#while collision:
		#	add_collision_exception_with(collision.collider)
		#	collidelist.append(collision.collider)

		#	collision=move_and_collide(Vector2(0,0),true,true,true)

		#print((global_position-attachpos).length())
		
		#old algorithm

		#var voltage=charge/(global_position-attachpos).length() #calculated based on Q/r
		#var current=voltage/resistance # dps
		#for colliderbox in collidelist:
		#	var collider=colliderbox.get_parent()
		#	#print(collider)

		#	collider.set_damage(0.03*current)
		#	#print(charge)
		#	attached_to.charge-=sign(attached_to.charge)*0.03*current
		#	charge-=sign(charge)*0.03*current

		
		##new algorithm
		#print(collidelist[0].get_parent().health_bar)
		var total_conductivity=0
		for colliderbox in collidelist:
			var collider=colliderbox.get_parent()
			total_conductivity += conductivity_factor/collider.max_health+base_conductivity

		var charge_released=charge*(1-exp(-0.03/((global_position-attachpos).length()/total_conductivity)))
		for colliderbox in collidelist:
			var collider=colliderbox.get_parent()
			var this_object_conductivity=conductivity_factor/collider.max_health+base_conductivity
			collider.set_damage(charge_released*this_object_conductivity/total_conductivity)

		attached_to.charge-=sign(attached_to.charge)*abs(charge_released)
		charge-=sign(charge)*abs(charge_released)
		
		
		return 0.03
	return 0
func _draw():
	get_pair_information()
	to_local=global_transform.affine_inverse()
	draw_line(Vector2(0, 0),to_local*attachpos, Color(0.5, 0.5, 0.5), 1)

func _process(delta):
	get_pair_information()
	$conductor.shape.b=to_local*attachpos
	to_local=global_transform.affine_inverse()

	tick += delta
	var dur = tick - last_tick
	var del = cst_movement(dur)
	update()
	
	last_tick += del
	if abs(charge)<=500:
		$ball.play("neutral")
	if(self.position.x > 960*2 or self.position.x < -960):
		print(charge)	
		call_deferred("free")
	elif(self.position.y < -400):
		print(charge)	
		call_deferred("free")
		
	if self.position.y >= 400:
		print(charge)	
		call_deferred("free")

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
