extends Node2D

var mode = -1

signal update_description

func _ready():
	pass


func _on_TextureButton_pressed():
	mode = 2
	emit_signal("update_description")

func _on_TextureButton2_pressed():
	mode = 3
	emit_signal("update_description")

func _on_TextureButton3_pressed():
	mode = 4
	emit_signal("update_description")

func _on_TextureButton4_pressed():
	mode = 5
	emit_signal("update_description")

func _on_TextureButton5_pressed():
	mode = 6
	emit_signal("update_description")
