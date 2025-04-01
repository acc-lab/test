extends Node

var sounds = {}  # Dictionary to store preloaded sounds

func _ready():
	set_global_volume(0.1)
	preload_sounds()  #; Load all sounds from this folder
	
func set_global_volume(volume: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume))

func preload_sounds():
	var sound_ext = ["wav"]
	var files = [
		"Alarm.wav",
		"Bow.wav",
		"Buy.wav",
		"Chamber Coin",
		"Chamber Coin 2.wav",
		"Chicken.wav",
		"Chicken 2.wav",
		"Chicken 3.wav",
		"Click.wav",
		"Coin 2.wav",
		"Coin 3.wav",
		"Dash.wav",
		"Dash 2.wav",
		"Dooz.wav",
		"Flesh Hit.wav",
		"Gameover 3.wav",
		"Jab.wav",
		"Ka Ching.wav",
		"Laser.wav",
		"Level Complete.wav",
		"Ping.wav",
		"Reveal.wav",
		"Revive.wav",
		"RIP sound.wav",
		"Select Good.wav",
		"Splat.wav",
		"Split Hit.wav",
		"Dooz.wav",
		"Flesh Hit.wav",
		"Squeak.wav",
		"Swing.wav",
		"Swing 2.wav",
		"Sword Slash.wav",
		"Tear.wav",
		"Unlock.wav",
	]
	
	for file in files:
		if sound_ext.has(file.get_extension()):
			sounds[file.get_basename()] = ResourceLoader.load("res://assets/SFX/{name}".format({"name":file}))
			print("Loaded sound: ", file)
		
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
