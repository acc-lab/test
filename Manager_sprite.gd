extends Node

func _ready():
	pass

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0

func leftcpr(a, b):
	return a.position.x < b.position.x
	
func spawn_random():
	if ticks > 1:
		ticks -= 1
		var RI = rng.randi_range(1, 100)
		
		if RI >= 20:
			# instantiate with name scenes[scene_num]
			# var sc = preloads.scene[preloads.scenes[rng.randi_range(0, 4)]]
			
			var sc = Preloads.scene["sprite_template"]
			var instance = sc.instance()
			
			instance.set("variant", Preloads.variants[rng.randi_range(0, 4)])
			instance.set("uuid", UUID)
			if rng.randi_range(1, 100)>=50:
				instance.set("team", 1)
			else:
				instance.set("team", 2)
			instance.set("observe_target_x", null)

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
		
		if(ch.team == 2):
			target = ch.position.x
		else:
			ch.observe_target_x = target
	
	
		
			
