extends Node

onready var UI = $"../UI"
onready var board = $"../UI/board"

func new_sprite(variant, team, coord = null, x = null):
	var RI = rng.randi_range(-20, 20)
		
	var sc = Preloads.scene["sprite_template"]
	var instance = sc.instance()
	
	var script = Preloads.method[variant]
	instance.set_script(script)
	
	instance.set("variant", variant)
	instance.set("uuid", UUID)
	instance.set("team", team)
	instance.set("observe_target_x", null)
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
	
	#new_sprite("axy", 1)
	#new_sprite("axy", 2)
	

var rng = RandomNumberGenerator.new()

var ticks = 0
var UUID = 0

var manager_projectile

var worth = 0
var worths = 8
var totaltick = 0
var timegap = 15

var enemy_spawn_global_x = 980

func leftcpr(a, b):
	return a.position.x < b.position.x
	
func adjust():
	if totaltick >= 30:
		worths = 10
		
		UI.mps = 10
		
	if totaltick >= 45:
		worths = 12
		timegap = 30
		
		UI.mps = 12
		
	if totaltick >= 95:
		worths = 15
		timegap = 20
		
		UI.mps = 15
		
	if totaltick >= 180:
		worths = 20
		timegap = 25
		
		UI.mps = 19
		
	if totaltick >= 270:
		worths = 25
		timegap = 5
		
		UI.mps = 23
		
	if totaltick >= 360:
		worths = 35
		timegap = 20
		
		UI.mps = 32
		
	if totaltick >= 450:
		worths = 45
		timegap = 30
		
		UI.mps = 40
		
	if totaltick >= 550:
		worths = 55
		timegap = 40
		
		UI.mps = 48
		
	if totaltick >= 750:
		worths = 65
		timegap = 50
		
		UI.mps = 55
		
	if totaltick >= 860:
		worths = 100
		timegap = 60
		
		UI.mps = 85
		
	if totaltick >= 1000:
		worths = 120
		timegap = 90
		
		UI.mps = 100
	
func spawn_random():
	$"../UI/wave indicator/text displayer".bbcode_text = "[center]Until next wave: "+str(int(timegap-ticks))+"[/center]"
		
		
	if ticks > timegap:
		adjust()
		
		new_wave()
		
		worth += timegap*worths
		ticks -= timegap
		
		# print("New wave at ", int(totaltick), ": ", worth, " with worth +", worths, "*", timegap)
		
		var RI = rng.randi_range(1, 100)
		
		while (RI >= 70):
			if (worth >= 500):
				new_enemy("police")
				worth -= 500
			else:
				break
			RI = rng.randi_range(1, 100)
		
		RI = rng.randi_range(1, 100)
		
		while (RI >= 70):
			if (worth >= 100):
				new_enemy("archer2")
				worth -= 100
			else:
				break
			RI = rng.randi_range(1, 100)
			
		RI = rng.randi_range(1, 100)
		
		while (RI >= 50):
			if (worth >= 250):
				new_enemy("tank")
				worth -= 250
			else:
				break
			RI = rng.randi_range(1, 100)
			
		RI = rng.randi_range(1, 100)
		
		while (RI >= 30):
			if (worth >= 30):
				new_enemy("axy")
				worth -= 30
			else:
				break
			RI = rng.randi_range(1, 100)
	
	#if Input.is_key_pressed(KEY_1):
	#	new_sprite("axy", 2)
	#	
	#elif Input.is_key_pressed(KEY_2):
	#	new_sprite("archer2", 2)
	#	
	#elif Input.is_key_pressed(KEY_3):
	#	new_sprite("tank", 2)
	#	
	#elif Input.is_key_pressed(KEY_4):
	#	new_sprite("police", 2)
	#	
	#elif Input.is_key_pressed(KEY_5):
	#	new_sprite("healer", 2)
			

func _process(delta):
	ticks += delta
	totaltick += delta
	
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
			
	target = 940
	for i in range(len(children)-1, -1, -1):
		ch = children[i]
		
		if(ch.get("team") == 2):
			target = ch.position.x
		else:
			ch.observe_target_x = target

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
