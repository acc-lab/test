extends Node

func _ready():
	manager_projectile = get_parent().get_node("Manager (projectile)")
	
	var sc = Preloads.scene["sprite_template"]
	var instance = sc.instance()
	
	var variant = Preloads.variants[1]
	
	var script = Preloads.method[variant]
	instance.set_script(script)
	
	instance.set("variant", variant)
	instance.set("uuid", UUID)
	instance.set("team", 1)
	instance.set("observe_target_x", null)
	instance.connect("_shoot_projectile", manager_projectile, "_shoot_projectile")
	
	UUID += 1
	
	add_child(instance)
	
	var instance2 = sc.instance()
	
	instance2.set_script(Preloads.method[Preloads.variants[0]])
	
	instance2.set("variant", Preloads.variants[0])
	instance2.set("uuid", UUID)
	instance2.set("team", 2)
	instance2.set("observe_target_x", null)
	instance2.connect("_shoot_projectile", manager_projectile, "_shoot_projectile")
	
	UUID += 1
	
	add_child(instance2)
	

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
		
		if RI >= 0:
			# instantiate with name scenes[scene_num]
			
			var sc = Preloads.scene["sprite_template"]
			var instance = sc.instance()
			
			var variant = Preloads.variants[1]
			
			var script = Preloads.method[variant]
			instance.set_script(script)
			
			instance.set("variant", variant)
			instance.set("uuid", UUID)
			if rng.randi_range(1, 100)>=50:
				instance.set("team", 1)
			else:
				instance.set("team", 2)
			instance.set("observe_target_x", null)
			instance.connect("_shoot_projectile", manager_projectile, "_shoot_projectile")
			
			UUID += 1
			
			add_child(instance)

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
	
	
		
			
