extends KinematicBody2D

onready var health = 2000
onready var max_health = 2000
onready var health_bar = $"health bar"


signal defeated
var emitted = false

func _ready():
	health_bar.max_value = max_health
	health_bar.value = health
	$AOEHitbox.get_node("hitbox").shape=$hitbox.shape
	$AOEHitbox.set_collision_layer(1)
	$AOEHitbox.set_collision_mask(0)
	
func _process(delta):
	$AOEHitbox.get_node("hitbox").position=$hitbox.position

func set_damage(damage):
	health -= damage
	health_bar.value = health
	
	if health <= 0 and not emitted:
		emit_signal("defeated")
		emitted = true
		
		call_deferred("free")
	
func set_heal(healing):
	pass # doesn't work
