extends KinematicBody2D

signal _move(steps)
signal _damage(damage)

func _ready():
	pass

func _move(steps):
	emit_signal("_move", steps)
	
func set_damage(damage):
	emit_signal("_damage", damage)

