extends KinematicBody2D

onready var sprite = $Sprite

var uuid
var team = 1
var vx=18
var vy=-0.1
var ax=0
var ay=0.5
var damage

var tick=0
var last_tick=0

func _ready():
	self.position.x = 0
	self.position.y = 200

func cst_movement(dur):
	if dur >= 0.03:
		self.position.x+=vx;
		self.position.y+=vy;
		vx+=ax;
		vy+=ay;
		return 0.03
	return 0

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	self.rotation_degrees = atan2(vy, vx)*180/PI
	print(self.rotation_degrees)
	self.scale.x = 1*getDir()
	
	var del = cst_movement(dur)
	
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
