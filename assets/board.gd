extends StaticBody2D

onready var tilemap = $"../board/TileMap"
onready var button_manager = $"../button manager"
onready var UI = $".."

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
					
			if event.button_index == BUTTON_WHEEL_UP:
				if(Input.is_key_pressed(KEY_SHIFT)):
					tilemap.position.x += 5
				else:
					tilemap.position.y += 5
				
			if event.button_index == BUTTON_WHEEL_DOWN:
				if(Input.is_key_pressed(KEY_SHIFT)):
					tilemap.position.x -= 5
				else:
					tilemap.position.y -= 5
		
		
		
