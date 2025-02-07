extends KinematicBody2D

signal _move(steps)
signal _damage(damage)
signal _heal(healing)
signal _attack()

func _ready():
	pass

func _move(steps):
	emit_signal("_move", steps)
	
func set_damage(damage):
	emit_signal("_damage", damage)
	
func set_healing(healing):
	print("dumb")
	emit_signal("_heal", healing)

func _attack():
	emit_signal("_attack")
