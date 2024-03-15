extends Node2D

var variant = "axy"

var uuid
var team = 1
var observe_target_x=0
var state = "idle"

var effect=0
var health=100

var body
var animator
var sprite

signal _shoot_projectile(type, arguments)

onready var health_bar = $"health bar"

func _ready():			
	var sc = Preloads.scene[variant]
	var instance = sc.instance()
	
	if team==1: self.position.x = 220
	else: self.position.x = 720
	
	self.position.y = 400
	
	add_child(instance)
	
	instance.connect("_move", self, "_move")
	instance.connect("_damage", self, "_damage")
	instance.connect("_attack", self, "_attack")
	
	body = instance
	
	animator = body.get_node("animator")
	sprite = body.get_node("AnimatedSprite")
	
	animator.current_animation = "idle"
	
	health_bar.min_value = 0
	health_bar.max_value = health
	health_bar.value = health
	
	body.set_collision_layer(team)
	body.set_collision_mask(0)
	
var tick = 0
var last_tick = 0
var last_state

func exceed(a, b, dir):
	if dir > 0: return Constants.gneq(a, b)
	else: return Constants.gneq(b, a)

func cst_movement(dur):
	if(state == "walk" and Constants.geq(dur,0.42)):
		state = "idle"
		return 0.42
	elif(state == "idle"):
		#print(self.position.x + 450*getDir(), " ", observe_target_x)
		if exceed(self.position.x + 450*getDir(), observe_target_x, getDir()):
			state = "attack"
		else:
			state = "walk"
		return 0
	elif(state == "attack"):
		if Constants.geq(dur, 0.36):
			#print("shoot!")
			state = "after_attack"
			return 0.36
	elif(state == "after_attack"):
		if Constants.geq(dur, 1.17):
			state = "idle"
			return 1.17
			#print("super idle")
	
	return 0
			
	#print(uuid, " ", state)

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	self.body.scale.x = 1*getDir()
	if(!animator.current_animation): animator.current_animation = "idle"
	
	var del = cst_movement(dur)
	
	if(state != last_state):
		var anim = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle"}[state]
		animator.current_animation = anim
		last_tick += del
		last_state = state
		
	health_bar.value = health
	
	if(health <= 0):
		call_deferred("free")
		
	#if(self.position.x > 920):
	#	self.position.x -= 940

func getDir():
	var direction
	if team==1:
		direction = 1
	else:
		direction = -1
	return direction
	
func _move(steps):
	health -= 1
	self.position.x += steps * getDir()
	
func _damage(damage):
	health -= damage
	effect = 10
	print(health)
	
func _attack():
	print("I should attack")
	
	emit_signal("_shoot_projectile", "arrows", [])
