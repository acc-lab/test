extends KinematicBody2D

signal _move(steps)
signal _damage(damage)
signal _attack()

func _ready():
	pass

func _move(steps):
	emit_signal("_move", steps)
	
func set_damage(damage):
	emit_signal("_damage", damage)

func _attack():
	print("hi")
	emit_signal("_attack")
