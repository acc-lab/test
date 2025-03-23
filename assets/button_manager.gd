extends Node2D

var mode = -1
onready var UI = $".."

signal update_description

func _ready():
	pass
	
func _process(delta):
	for i in $"NinePatchRect/button container/VBoxContainer".get_children():
		for j in i.get_children():
			j.material.set_shader_param("cd_effect",
				( UI.cooldown[int(j.get_name())] - UI.delay[int(j.get_name())])
				/
				UI.cooldown[int(j.get_name())]
			)
			if UI.money>=UI.price[int(j.get_name())]:
				j.material.set_shader_param("effect",0)
			else:
				j.material.set_shader_param("effect",1)
				
		
func _on_UI_summon(target_mode):
	mode = target_mode
	emit_signal("update_description")
