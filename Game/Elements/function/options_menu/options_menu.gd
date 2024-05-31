extends ColorRect

@onready var windowed_button = $WindowMode/WindowedButton
@onready var current_volume = $VolumeSetting/CurrentVolume


func _input(event):
	if event.is_action("escape"):
		CloseMenu()

func _on_back_button_pressed():
	CloseMenu()

func CloseMenu():
	self.visible = false



func _ready():
	if get_window().mode == 0: #windowed
		windowed_button.text = "WINDOWED"
	elif get_window().mode == 3: #fullscreen
		windowed_button.text = "FULLSCREEN"
	
	AudioServer.get_bus_name(0)
	


func _on_windowed_button_pressed():
	if get_window().mode == get_window().MODE_WINDOWED:
		get_window().mode = get_window().MODE_FULLSCREEN
		windowed_button.text = "FULLSCREEN"
	
	elif get_window().mode == get_window().MODE_FULLSCREEN:
		get_window().mode = get_window().MODE_WINDOWED
		windowed_button.text = "WINDOWED"
	



func _on_increase_volume_pressed():
	# must test, theres no way this works properly
	AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) + 5)

func _on_decrease_volume_pressed():
	AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) - 5)
