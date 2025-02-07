extends Light2D

var timer = 0

func _ready():
	pass
	
func _process(dur):
	timer += dur
	self.energy = 1.2 + 0.05 * sin(timer*2)
