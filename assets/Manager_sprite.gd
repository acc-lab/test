extends Node

onready var UI = $"../UI"
onready var board = $"../UI/board"
onready var scene = $".."

func new_sprite(variant, team, coord = null, x = null):
	var sc = Preloads.scene["sprite_template"]
	var instance = sc.instance()
	
	var script = Preloads.method[variant]
	instance.set_script(script)
	
	instance.set("variant", variant)
	instance.set("uuid", UUID)
	instance.set("team", team)
	instance.set("observe_target_x", null)
	
	instance.get_child(0).visible = $"..".debug_alwaysShowHP
	if variant == "tank":
		instance.get_child(0).visible = true
	
	instance.connect("_shoot_projectile", manager_projectile, "_shoot_projectile")
	instance.connect("free_tile", board, "free_tile")
	
	if x != null:
		instance.position.x = x
		
	else:
		if team == 1:
			instance.position.x = 20
		else:
			instance.position.x = 940
	
	UUID += 1
	
	instance.coord = coord
	
	add_child(instance)
	
func new_enemy(type):
	new_sprite(type, 2, null, enemy_spawn_global_x)
	enemy_spawn_global_x += 30
	
func new_wave():
	enemy_spawn_global_x = 980

func _ready():
	manager_projectile = get_parent().get_node("Manager (projectile)")
	
	Engine.time_scale = 1
	
	#new_sprite("axy", 1)
	#new_sprite("axy", 2)
	

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0

var manager_projectile

var worth = 0
var worths = 0
var totaltick = 0
var timegap = 15

var enemy_spawn_global_x = 980

func leftcpr(a, b):
	return a.position.x < b.position.x
	
func adjust():
	if totaltick >= 0:
		worths = 8*scene.difficulty
		
		UI.mps = 8
		
	if totaltick >= 30:
		worths = 10*scene.difficulty
		
		UI.mps = 10
		
	if totaltick >= 45:
		worths = 12*scene.difficulty
		timegap = 30
		
		UI.mps = 12
		
	if totaltick >= 95:
		worths = 15*scene.difficulty
		timegap = 20
		
		UI.mps = 15
		
	if totaltick >= 180:
		worths = 20*scene.difficulty
		timegap = 25
		
		UI.mps = 19
		
	if totaltick >= 270:
		worths = 25*scene.difficulty
		timegap = 5
		
		UI.mps = 23
		
	if totaltick >= 360:
		worths = 35*scene.difficulty
		timegap = 20
		
		UI.mps = 32
		
	if totaltick >= 450:
		worths = 45*scene.difficulty
		timegap = 30
		
		UI.mps = 40
		
	if totaltick >= 550:
		worths = 55*scene.difficulty
		timegap = 40
		
		UI.mps = 48
		
	if totaltick >= 750:
		worths = 65*scene.difficulty
		timegap = 50
		
		UI.mps = 55
		
	if totaltick >= 860:
		worths = 100*scene.difficulty
		timegap = 60
		
		UI.mps = 85
		
	if totaltick >= 1000:
		worths = 120*scene.difficulty
		timegap = 90
		
		UI.mps = 100
	
var cd = 0

func temp():
	if ticks > timegap:
		print("DIFFICULTY:", scene.difficulty)
		
		adjust()
		
		new_wave()
		
		worth += timegap*worths
		ticks -= timegap
		
		print("New wave at ", int(totaltick), ": ", worth, " with worth +", worths, "*", timegap)
		
		var networth = worth
		
		var RI: int
		
		var spawnCondition = {
			"police": {"rate": 60, "worth": UI.price[5]}, 
			"archer2": {"rate": 80, "worth": UI.price[3]}, 
			"tank": {"rate": 50, "worth": UI.price[4]}, 
			"axy": {"rate": 70, "worth": UI.price[2]}, 
			"ninja": {"rate": 70, "worth": UI.price[6]}, 
			"healer": {"rate": 20, "worth": UI.price[7]}, 
			"chicken": {"rate": 90, "worth": UI.price[8]}, 
			"slime": {"rate": 80, "worth": UI.price[9]}, 
		}
		
		while (2*worth >= networth):
			for type in spawnCondition:
				RI = rng.randi_range(1, 100)
			
				while (RI <= spawnCondition[type]["rate"]): # 60%
					if (worth >= spawnCondition[type]["worth"]):
						new_enemy(type)
						worth -= spawnCondition[type]["worth"]
					else:
						break
					RI = rng.randi_range(1, 100)
					
				print("Spawned ", type, ": ", worth, "/", networth)
	
func spawn_random():
	# remove this line, then Manager (sprite) can work independently
	$"../UI/wave indicator/text displayer".bbcode_text = "[center]Until next wave: "+str(int(timegap-ticks))+"[/center]"
		
	temp()
	
func spawn_debug():
	cd -= 1
	
	if cd<0: cd=0
	
	if Input.is_action_pressed("ui_up") and cd == 0:
		new_sprite("slime", 1)
		cd += 15
		
	elif Input.is_action_pressed("ui_left") and cd == 0:
		if(Engine.time_scale >= 1.2):
			Engine.time_scale -= 0.2
		cd += 15
		
	elif Input.is_action_pressed("ui_down") and cd == 0:
		new_sprite("chicken", 2)
		cd += 15
		
	elif Input.is_action_pressed("ui_right") and cd == 0:
		if(Engine.time_scale <= 3):
			Engine.time_scale += 0.2
		cd += 15
		
	elif Input.is_key_pressed(KEY_1) and cd == 0:
		new_sprite("axy", 2)
		cd += 15
		
	elif Input.is_key_pressed(KEY_2) and cd == 0:
		new_sprite("archer2", 2)
		cd += 15
		
	elif Input.is_key_pressed(KEY_3) and cd == 0:
		new_sprite("tank", 2)
		cd += 15
		
	elif Input.is_key_pressed(KEY_4) and cd == 0:
		new_sprite("police", 2)
		cd += 15
		
	elif Input.is_key_pressed(KEY_5) and cd == 0:
		new_sprite("ninja", 2)
		cd += 15
		
	elif Input.is_key_pressed(KEY_6) and cd == 0:
		new_sprite("healer", 2)
		cd += 15
			
			

func _process(delta):
	ticks += delta
	totaltick += delta
	
	if not $"..".debug_stopWave:
		spawn_random()
		
	if $"..".debug:
		spawn_debug()
	
	var children = get_children()
	children.sort_custom(self, "leftcpr")
	
	var target = 20
	var ch
	
	var leading = [-1, 20, 880]
	
	for i in range(len(children)):
		ch = children[i]
		
		if(ch.team == 1):
			if ch.position.x > 20:
				target = ch.position.x
				
			leading[1] = max(leading[1], ch.position.x)
		else:
			ch.observe_target_x = target
			
	target = 940
	for i in range(len(children)-1, -1, -1):
		ch = children[i]
		
		if(ch.get("team") == 2):
			if ch.position.x < 940:
				target = ch.position.x
				
			leading[2] = min(leading[2], ch.position.x)
		else:
			ch.observe_target_x = target
			
	for child in children:
		child.observe_leading_x = leading[child.team]

func _on_Button_pressed():
	var RI = rng.randi_range(1, 100)
	
	if RI >= 60:
		new_sprite("archer2", 1)
		
	elif RI >= 30:
		new_sprite("axy", 1)
	else:
		new_sprite("tank", 1)



func _on_board_summon(coord, type):
	new_sprite(type, 1, coord)
