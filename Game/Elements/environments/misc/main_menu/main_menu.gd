extends Node3D

@onready var gui = $GUI
@onready var options_menu = $GUI/OptionsMenu
@export var initial_level : String

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_button_pressed():
	#get_tree().change_scene_to_packed(initial_level)
	get_tree().change_scene_to_file(initial_level)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	options_menu.visible = true

