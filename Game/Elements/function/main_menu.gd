extends Node3D


@onready var gui = $GUI
@onready var options_menu = $GUI/OptionsMenu

@export var initial_level : String
@export var player_hub : String = "res://Elements/environments/misc/player_cell.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print_rich("[font_size=120][color=CORNFLOWER_BLUE][wave]heck you")
	

func _on_play_button_pressed():
	var save = SaveGame.new()
	
	if save.load_game() == null:
		NewGame()
	
	else:
		# Save file found
		if save.load_game().level:
			if save.load_game().level == "res://Elements/environments/chapter1/c1_m1.tscn":
				LoadingScreen.next_scene = save.load_game().level
				LoadingScreen.scene_transition()
			
			else:
				LoadingScreen.next_scene = player_hub
				LoadingScreen.scene_transition()
				
			
		# If save file found, but bad data (corrupted, or something generally wrong)
		else:
			NewGame()
	

func NewGame():
	push_error("Creating New Game")
	LoadingScreen.next_scene = initial_level
	LoadingScreen.scene_transition()


func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	options_menu.visible = true