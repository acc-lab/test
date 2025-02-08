extends Node

signal defeated
signal victory
signal restart

var difficulty = 1
var debug = false
var debug_alwaysShowHP = false

func _on_castle1_defeated():
	emit_signal("defeated")
	
	call_deferred("free")

func _on_castle2_victory():
	emit_signal("victory")
	
	call_deferred("free")

func _restart():
	emit_signal("restart")
	
	call_deferred("free")
	
onready var camera = $Camera2D

var shake_amount = 0.0
var default_offset = Vector2.ZERO
var is_shaking = false

func _ready():
	if camera:
		default_offset = camera.offset
	
	if debug:
		difficulty = 10
		$UI.money = 99999999
		
func _process(delta):
	if is_shaking and camera:
		camera.offset = Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		)

var current_tween: Tween = null
var current_timer = null

# main shake function, call this to shake screen
# intensity = how strong, duration = how long, falloff = fade out or not
func shake(intensity = 10.0, duration = 0.3, falloff = true):
	# cleanup old tween if exists
	if current_tween:
		current_tween.queue_free()
	
	shake_amount = intensity
	is_shaking = true
	
	# setup new tween for smooth animation
	current_tween = Tween.new()
	add_child(current_tween)
	
	if falloff:
		# gradually reduce shake intensity
		current_tween.interpolate_property(
			self, 
			"shake_amount",
			intensity,
			0.0,
			duration,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT
		)
	
	current_tween.start()
	
	# wait for shake to finish
	var timer = get_tree().create_timer(duration)
	yield(timer, "timeout")
	
	# cleanup after shake
	if is_shaking:
		is_shaking = false
		if camera:
			camera.offset = default_offset
		if current_tween:
			current_tween.queue_free()
			current_tween = null

# usage examples:
# normal shake: $ScreenShake.shake(10.0, 0.3)
# big shake: $ScreenShake.shake(50.0, 0.4)
# long shake: $ScreenShake.shake(20.0, 1.0)
# no falloff: $ScreenShake.shake(10.0, 0.3, false)
