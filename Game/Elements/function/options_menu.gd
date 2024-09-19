extends Control

@onready var scroll_menu = $ScrollContainer/VBoxContainer
@onready var sensitivity_slider = $ScrollContainer/VBoxContainer/SensitivitySlider
@onready var fullscreen_button = $ScrollContainer/VBoxContainer/FullscreenButton
@onready var music_slider = $ScrollContainer/VBoxContainer/MusicSlider
@onready var sfx_slider = $ScrollContainer/VBoxContainer/SFXSlider
@onready var ambience_slider = $ScrollContainer/VBoxContainer/AmbienceSlider

@onready var sensitivity_num = $ScrollContainer/VBoxContainer/SensitivityNum

@onready var save_data_reset = $ScrollContainer/VBoxContainer/SaveDataReset


const save_progression_path = "user://save.res"
const save_config_path = "user://config.res"
const save_playerhub_path = "user://cell.res"
const save_addtoplayerhub_path = "user://cell_add.res"
const save_name_path = "user://save_plrname.res"


var default_sensitivity = 0.15
var default_fullscreen = true
var default_musicvolume = 50
var default_sfxvolume = 50
var default_ambiencevolume = 50


func _input(event):
	if event.is_action("escape"):
		CloseMenu()

func _on_back_button_pressed():
	SaveCurrentSettings()
	CloseMenu()

func CloseMenu():
	self.visible = false


func _ready():
	#scroll_menu.visible = false
	var config = SaveConfig.new()
	
	#if !(config.load_config() == null):
	var loaded_config = config.load_config()
	
	
	sensitivity_slider.value = loaded_config.SENSITIVITY
	fullscreen_button.button_pressed = loaded_config.FULLSCREEN
	music_slider.value = loaded_config.VOLUME_MUSIC
	sfx_slider.value = loaded_config.VOLUME_SFX
	ambience_slider.value = loaded_config.VOLUME_AMBIENCE
	
	
	



func _on_sensitivity_slider_drag_ended(value_changed):
	sensitivity_num.text = str(sensitivity_slider.value)
	if value_changed:
		SaveCurrentSettings()

func _on_windowed_button_pressed():
	if get_window().mode == get_window().MODE_WINDOWED:
		get_window().mode = get_window().MODE_FULLSCREEN
		fullscreen_button.button_pressed = true
		SaveCurrentSettings()
	
	elif get_window().mode == get_window().MODE_FULLSCREEN:
		get_window().mode = get_window().MODE_WINDOWED
		fullscreen_button.button_pressed = false
		SaveCurrentSettings()

func _on_music_slider_drag_ended(value_changed):
	if value_changed:
		SaveCurrentSettings()

func _on_sfx_slider_drag_ended(value_changed):
	if value_changed:
		SaveCurrentSettings()

func _on_ambience_slider_drag_ended(value_changed):
	if value_changed:
		SaveCurrentSettings()



func _on_save_data_reset_button_down():
	await get_tree().create_timer(2).timeout
	
	
	if save_data_reset.is_hovered() and Input.is_action_pressed("click"):
		ClearSaveData()


func ClearSaveData():
	OS.move_to_trash(ProjectSettings.globalize_path(save_progression_path))
	OS.move_to_trash(ProjectSettings.globalize_path(save_config_path))
	OS.move_to_trash(ProjectSettings.globalize_path(save_playerhub_path))
	OS.move_to_trash(ProjectSettings.globalize_path(save_addtoplayerhub_path))
	OS.move_to_trash(ProjectSettings.globalize_path(save_name_path))
	
	OS.alert(
		"Save data has been deleted.

Amelioration will now close.
If this was a mistake, you can restore your files; They are located in your Recycling Bin",
		 "Success!"
		)
	get_tree().quit()



func SaveCurrentSettings():
	var config = SaveConfig.new()
	
	config.save_config(
		sensitivity_slider.value,
		fullscreen_button.button_pressed,
		music_slider.value,
		sfx_slider.value,
		ambience_slider.value
	)
