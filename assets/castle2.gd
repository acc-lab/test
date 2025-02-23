extends KinematicBody2D

onready var health = 6000*$"../../..".difficulty
onready var max_health = 6000*$"../../..".difficulty
onready var health_bar = $"health bar"

signal victory
var emitted = false

func _ready():
	health_bar.max_value = max_health
	health_bar.value = health
	
func set_damage(damage):
	health -= damage
	health_bar.value = health
	
	if health <= 0 and not emitted:
		emit_signal("victory")
		emitted = true
		
		call_deferred("free")
		
func set_heal(healing):
	pass # doesn't work
	
	
