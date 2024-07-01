extends Node

signal defeated
signal victory

var difficulty = 1

func _ready():
	pass

func _on_castle1_defeated():
	emit_signal("defeated")
	
	call_deferred("free")

func _on_castle2_victory():
	emit_signal("victory")
	
	call_deferred("free")


