extends Node

func new_sprite(variant, team):
	var sc = Preloads.scene["sprite_template"]
	var instance = sc.instance()
	
	var script = Preloads.method[variant]
	instance.set_script(script)
	
	instance.set("variant", variant)
	instance.set("uuid", UUID)
	instance.set("team", team)
	instance.set("observe_target_x", null)
	instance.connect("_shoot_projectile", manager_projectile, "_shoot_projectile")
	
	UUID += 1
	
	add_child(instance)
	

func _ready():
	manager_projectile = get_parent().get_node("Manager (projectile)")
	
	new_sprite("axy", 1)
	new_sprite("axy", 2)
	

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0

var manager_projectile

func leftcpr(a, b):
	return a.position.x < b.position.x
	
func spawn_random():
	if ticks > 1:
		ticks -= 1
		var RI = rng.randi_range(1, 100)
		
		if RI >= 90:
			new_sprite("archer2", 1)
			new_sprite("archer2", 2)
			
		elif RI >= 20:
			
			new_sprite("axy", 1)
			new_sprite("axy", 2)
			
		elif RI >= 10:
			new_sprite("police", 1)
			new_sprite("police", 2)

func _process(delta):
	ticks += delta
	
	spawn_random()
	
	var children = get_children()
	children.sort_custom(self, "leftcpr")
	
	var target = 20
	var ch
	for i in range(len(children)):
		ch = children[i]
		
		if(ch.team == 1):
			target = ch.position.x
		else:
			ch.observe_target_x = target
			
	target = 880
	for i in range(len(children)-1, -1, -1):
		ch = children[i]
		
		if(ch.get("team") == 2):
			target = ch.position.x
		else:
			ch.observe_target_x = target
	
	
		
			
