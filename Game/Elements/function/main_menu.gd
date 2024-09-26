extends Node3D


@onready var gui = $GUI
@onready var options_menu = $GUI/OptionsMenu

@onready var ui_select = $Audio/UISelect
@onready var ui_hover_1 = $Audio/UIHover1
@onready var ui_hover_2 = $Audio/UIHover2
@onready var ui_hover_3 = $Audio/UIHover3
@onready var ui_hover_4 = $Audio/UIHover4



@export var initial_level : String
@export var player_hub : String = "res://Elements/environments/misc/player_cell.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print_rich("[font_size=120][color=CORNFLOWER_BLUE][wave]heck you")
	
	await get_tree().create_timer(2).timeout
	
	$"Audio/A-os".play()

func _on_play_button_pressed():
	$"Audio/A-os".stop()
	ui_select.play()
	var save = SaveGame.new()
	
	if save.load_game() == null:
		NewGame()
	
	else:
		# Save file found
		if save.load_game().level:
			if save.load_game().level == "res://Elements/levels/main_levels/c1_m1.tscn" or save.load_game().level == "res://Elements/levels/misc/intro_cutscene.tscn":
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
	ui_select.play()
	get_tree().quit()

func _on_options_button_pressed():
	ui_select.play()
	options_menu.visible = true




func _on_play_button_mouse_entered():
	ui_hover_1.play()

func _on_options_button_mouse_entered():
	ui_hover_2.play()

func _on_quit_button_mouse_entered():
	ui_hover_3.play()
