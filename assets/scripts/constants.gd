extends Node

var machine_eps = 1.0 # initial value

"""
While I used the machine epsilon, it's worthy to note that the "dur" or "tick" in the _process function
can still accumulate deviation. On the other hand, since the delta time fluctuates, the game logic
(which entirely depends on when AnimationPlayer play animations) is not entirely deterministic. However,
even though animations of AnimationPlayer and the _process mainloop are independent, we can still expect
the _process function delay is globally the same among characters (skeletons) (*right?).
"""

func _ready():
	# process the machine epsilon
	while machine_eps + 1 > 1:
		machine_eps /= 2
	machine_eps *= 2
	
func gneq(a, b):
	return not (a <= b+machine_eps)

func geq(a, b):
	return (a >= b-machine_eps)

func eq(a,b):
	return (abs(a-b) <= machine_eps)
	
func to30msmul(dur):
	return floor(dur/0.03)*0.03
