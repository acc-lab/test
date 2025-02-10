extends KinematicBody2D


var uuid
var team = 1
var vx
var vy
var ax
var ay

var voltage #determine dps and shown sprite
var attached_to
var to_local

var tick=0
var last_tick=0

# Called when the node enters the scene tree for the first time.
func _ready():
	$conductor.shape=SegmentShape2D.new()
	$conductor.shape.a=Vector2(0,0)

	if voltage>0:
		$ball.play("positive")
	else:
		$ball.play("negative")
	#var cable=$conductor.shape
	#print(cable.a,attached_to.position)
	set_collision_layer(0)
	set_collision_mask(0)

func cst_movement(dur):
	if dur >= 0.03:
		position += Vector2(vx, vy)
		
		vx+=ax;
		vy+=ay;
			
		return 0.03
	return 0
func _draw():
	to_local=global_transform.affine_inverse()
	draw_line(Vector2(0, 0),attached_to.position+Vector2(0,-10)-self.global_position, Color(0.5, 0.5, 0.5), 1)

func _process(delta):
	to_local=global_transform.affine_inverse()
	#print(global_transform*Vector2(0,0))
	tick += delta
	var dur = tick - last_tick
	
	var del = cst_movement(dur)
	$conductor.shape.b=attached_to.position+Vector2(0,-10)-self.global_position
	print(uuid,self.global_position)
	update()
	
	last_tick += del
		
	if(self.position.x > 960*2 or self.position.x < -960):
		#ManagerParticle.emit_particle("heal_particle_1",self.position)
		call_deferred("free")
	elif(self.position.y < -400):
		#ManagerParticle.emit_particle("heal_particle_1",self.position)
		call_deferred("free")
		
	if self.position.y >= 400:
		call_deferred("free")

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
