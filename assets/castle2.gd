extends KinematicBody2D

onready var health = 10000*$"../../..".difficulty
onready var max_health = 10000*$"../../..".difficulty
onready var health_bar = $"health bar"

signal victory

func _ready():
	health_bar.max_value = max_health
	health_bar.value = health
	
func set_damage(damage):
	health -= damage
	health_bar.value = health
	
	if health <= 0:
		emit_signal("victory")
		
		call_deferred("free")
	
	
