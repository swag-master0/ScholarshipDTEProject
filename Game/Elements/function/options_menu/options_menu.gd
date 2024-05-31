extends ColorRect

@onready var windowed_button = $WindowedButton

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

func _on_windowed_button_pressed():
	if get_window().mode == get_window().MODE_WINDOWED:
		get_window().mode = get_window().MODE_FULLSCREEN
		windowed_button.text = "FULLSCREEN"
	
	elif get_window().mode == get_window().MODE_FULLSCREEN:
		get_window().mode = get_window().MODE_WINDOWED
		windowed_button.text = "WINDOWED"
	
