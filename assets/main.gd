extends Node

var difficulty = 1

var instance 

func _ready():
	$menu.visible = true
	Engine.time_scale = 1
	
func _on_victory():
	$menu.visible = true
	difficulty += 0.1
	
	$menu/RichTextLabel2.text = "well I guess you win now. Current difficulty set to: " + str(difficulty)
	
func _on_defeated():
	$menu.visible = true
	if difficulty >= 0.15:
		difficulty -= 0.1
		
	$menu/RichTextLabel2.text = "well I guess you lost. Current difficulty set to: " + str(difficulty)


func _on_Button_pressed():
	$menu.visible = false
	start_game()
	
func start_game():
	var sc = load("res://assets/games scene.tscn")
	instance = sc.instance();
	
	instance.difficulty = difficulty
	
	instance.connect("victory", self, "_on_victory")
	instance.connect("defeated", self, "_on_defeated")
	instance.connect("restart",self,"_restart")
	add_child(instance)

func _restart():
	print("reached")

	start_game()

