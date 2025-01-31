extends KinematicBody2D

var uuid
var team = 1
var heal_amount=100 #hp

var heal_rate=1 #hp/s
var decay_rate=-1 #-hp/s

var tick=0
var last_tick=0

func _ready():
    set_collision_layer(1)

    #self.

func cst_movement():
    
