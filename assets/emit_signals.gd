extends KinematicBody2D

signal _move(steps)
signal _damage(damage)
signal _heal(healing)
signal _attack()

func _ready():
	$AOEHitbox.get_node("hitbox").shape=$hitbox.shape
	print($AOEHitbox.get_node("hitbox").shape)

func _move(steps):
	emit_signal("_move", steps)
	
func set_damage(damage):
	emit_signal("_damage", damage)
	
func set_heal(healing):
	emit_signal("_heal", healing)

func _attack():
	emit_signal("_attack")
