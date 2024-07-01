extends Node

var difficulty = 1


func _ready():
	$menu.visible = true
	
func _on_victory():
	$menu.visible = true
	difficulty += 0.1
	
	$menu/RichTextLabel2.text = "well I guess you win now. Current difficulty set to: " + difficulty
	
	
func _on_defeated():
	$menu.visible = true
	if difficulty >= 0.15:
		difficulty -= 0.1
		
	$menu/RichTextLabel2.text = "well I guess you lost. Current difficulty set to: " + difficulty

	
	


func _on_Button_pressed():
	$menu.visible = false
	
	var sc = load("res://assets/games scene.tscn")
	var instance = sc.instance()
	
	instance.difficulty = difficulty
	
	instance.connect("victory", self, "_on_victory")
	instance.connect("defeated", self, "_on_defeated")
	
	add_child(instance)

