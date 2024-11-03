extends Node2D

var variant = "axy"

var uuid
var team = 1
var observe_target_x=0
var state = "idle"
var phase = ""

var effect=0
var health

var body
var animator
var sprite

var coord = null

signal _shoot_projectile(type, arguments)
signal free_tile(coord)

onready var health_bar = $"health bar"

func _ready():			
	var sc = Preloads.scene[variant]
	var instance = sc.instance()
	
	self.position.y = 360
	
	add_child(instance)
	
	instance.connect("_move", self, "_move")
	instance.connect("_damage", self, "_damage")
	instance.connect("_attack", self, "_attack")
	
	body = instance
	
	animator = body.get_node("animator")
	sprite = body.get_node("AnimatedSprite")
	
	animator.current_animation = "idle"
	
	body.set_collision_layer(team)
	body.set_collision_mask(0)
	
	# set_health_bar()
	
func set_health_bar():
	health_bar.min_value = 0
	health_bar.max_value = health
	health_bar.value = health
	
var tick = 0
var last_tick = 0
var last_state = ""

var anims = {"walk":"walk", "attack":"attack", "idle":"idle", "after_attack":"idle", "before_attack": "idle"}

func exceed(a, b, dir):
	if dir > 0: return Constants.gneq(a, b)
	else: return Constants.gneq(b, a)
	
func within(a, b, c, dir):
	if dir > 0: return Constants.gneq(b, c) and Constants.gneq(c, a)
	else: return Constants.gneq(c, b) and Constants.gneq(a, c)

func cst_movement(dur):
	pass

func _process(delta):
	tick += delta
	
	var dur = tick - last_tick
	
	# if(variant == "axy"): print(dur)
	
	self.body.scale.x = 1*getDir()
	if(!animator.current_animation): animator.current_animation = "idle"
	
	var del = cst_movement(dur)
	
	last_tick += del
	
	# if(variant == "axy"): print(state)
	
	if(state != last_state):
		var anim = anims[state]
		animator.current_animation = anim
		last_state = state
		
	health_bar.value = health
	
	if(health <= 0):
		if coord != null:
			emit_signal("free_tile", coord)
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
	self.position.x += steps * getDir()
	
func _damage(damage):
	health -= damage
	effect = 10
	
func _attack():
	pass
