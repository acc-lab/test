extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var particles = {}
var particle_names= ["healing", "blood", "arrowHit", "bulletHit", "ninjaDash"]


# Called when the node enters the scene tree for the first time.
func _ready():
	for name in particle_names:
		particles[name] = load("res://assets/particles/{name}.tscn".format({"name":name}))

func emit_particle(type,  position, x_direction=1):
	if !particle_names.has(type):
		return -1
	var particle=particles[type].instance()
	#print(particle)
	#particle.res#tart()
	particle.z_index=100
	particle.position=position
	particle.set_emitting(true)
	particle.direction.x *= x_direction
	add_child(particle)
	return 0
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
