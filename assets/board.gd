extends StaticBody2D

onready var tilemap = $"../board/TileMap"
onready var button_manager = $"../button manager"
onready var UI = $".."
var right_button_down=false
var last_cursor_position=Vector2(0,0)

# -1 no such tile
# 0 out of border
# 1 not placed yet
# 2 ...

signal summon(coord, type)
signal UI_no_money

func _ready():
	set_process_input(true)

func _process(delta):
	pass
	
func free_tile(coord):
	tilemap.set_cell(coord.x, coord.y, 1)
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var zoom_pos
			
			if event.button_index == BUTTON_LEFT:
				# update tilemap
				var coord = tilemap.world_to_map(tilemap.to_local(event.position))
				var tile_id = tilemap.get_cell(coord.x, coord.y)
				if tile_id == 1:
					if(UI.delay[button_manager.mode] >= UI.cooldown[button_manager.mode]):
						if(UI.money >= UI.price[button_manager.mode]):
							UI.delay[button_manager.mode] = 0
							UI.money -= UI.price[button_manager.mode]
							tilemap.set_cell(coord.x, coord.y, button_manager.mode)
							
							emit_signal("summon", coord, UI.type[button_manager.mode]) 
						else:
							emit_signal("UI_no_money")
					
			if event.button_index == BUTTON_RIGHT:
				#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				right_button_down=true
				last_cursor_position=event.position
				#last_tilemap_position=tilemap.position
				#var current_cursor_position=tilemap.world_to_map(tilemap.to_local(event.position))
				#print(last_right_button,current_cursor_position,last_cursor_position)
				#tilemap.position=last_tilemap_position+current_cursor_position-last_cursor_position
			#tilemap.position.x += 5
		##if event.is_canceled():
		##	if event.button_index==BUTTON_RIGHT:
		##		right_button_down=false	
		else:
			if event.button_index==BUTTON_RIGHT:
				#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				right_button_down=false
	if event is InputEventMouseMotion:
		# print(right_button_down)
		if right_button_down:
			#viewport.warp_mouse(last_cursor_position)
			#print(event.position,last_cursor_position)
			#if (event.position-last_cursor_position).dot(event.relative)>0:
			tilemap.position+=event.relative

func _on_board_mouse_exited():
	right_button_down=false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
