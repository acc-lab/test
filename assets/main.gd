extends Node


func _ready():
	$menu.visible = true
	
func _on_victory():
	$menu.visible = true
	$menu/RichTextLabel2.text = "well I guess you win now"
	
func _on_defeated():
	$menu.visible = true
	$menu/RichTextLabel2.text = "well I guess you lost"


func _on_Button_pressed():
	$menu.visible = false
	
	var sc = load("res://assets/games scene.tscn")
	var instance = sc.instance()
	
	instance.connect("victory", self, "_on_victory")
	instance.connect("defeated", self, "_on_defeated")
	
	add_child(instance)

