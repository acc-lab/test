extends StaticBody2D

onready var tilemap = $"../board/TileMap"
onready var button_manager = $"../button manager"

# -1 no such tile
# 0 out of border
# 1 not placed yet
# 2 ...

signal summon(coord, type);

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
				var coord = tilemap.world_to_map(tilemap.to_local(event.global_position))
				var tile_id = tilemap.get_cell(coord.x, coord.y)
				if tile_id == 1:
					tilemap.set_cell(coord.x, coord.y, button_manager.mode)
					
					emit_signal("summon", coord, ["axy", "archer2", "tank", "police", "healer"][button_manager.mode-2])
			
					
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
		
		
		
