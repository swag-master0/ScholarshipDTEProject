extends Node3D


@onready var gui = $GUI
@onready var options_menu = $GUI/OptionsMenu

@export var initial_level : String

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_button_pressed():
	var save = SaveGame.new()
	
	if save.load_game() == null:
		push_error("No save file detected: Restarting")
		LoadingScreen.next_scene = initial_level
		LoadingScreen.scene_transition()
		
		
	else:
		LoadingScreen.next_scene = save.load_game().level
		LoadingScreen.scene_transition()
	
	
	
	

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	options_menu.visible = true

