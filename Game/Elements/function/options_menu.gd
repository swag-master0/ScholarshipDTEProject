extends Control

@onready var fullscreen_button = $ScrollContainer/VBoxContainer/FullscreenButton



func _input(event):
	if event.is_action("escape"):
		CloseMenu()

func _on_back_button_pressed():
	CloseMenu()

func CloseMenu():
	self.visible = false



func _ready():
	if get_window().mode == 0: #windowed
		fullscreen_button.button_pressed = false
	elif get_window().mode == 3: #fullscreen
		fullscreen_button.button_pressed = true

func _on_windowed_button_pressed():
	if get_window().mode == get_window().MODE_WINDOWED:
		get_window().mode = get_window().MODE_FULLSCREEN
		fullscreen_button.button_pressed = true
	
	elif get_window().mode == get_window().MODE_FULLSCREEN:
		get_window().mode = get_window().MODE_WINDOWED
		fullscreen_button.button_pressed = false
	



