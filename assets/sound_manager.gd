extends Node

var sounds = {}  # Dictionary to store preloaded sounds

func _ready():
	set_global_volume(0.03)
	preload_sounds("res://assets/SFX/")  # Load all sounds from this folder
	
func set_global_volume(volume: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume))

func preload_sounds(path: String):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".wav") or file_name.ends_with(".ogg") or file_name.ends_with(".mp3"):
				var sound_path = path + file_name
				sounds[file_name.get_basename()] = load(sound_path)
				print("Loaded sound:", file_name)
			file_name = dir.get_next()
	else:
		print("Error: Could not open directory:", path)
		
func play_sound_random(sound_names: Array):
	var random_sound_name = sound_names[randi() % sound_names.size()]
	
	play_sound(random_sound_name)
	
func play_sound(sound_name: String):
	if sound_name in sounds:
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.stream = sounds[sound_name]
		audio_player.play()
		audio_player.connect("finished", audio_player, "queue_free")
	else:
		print("Error: Sound not found -", sound_name)
