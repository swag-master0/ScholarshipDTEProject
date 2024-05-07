extends Node3D

@export var initial_level : PackedScene

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(initial_level)

func _on_quit_button_pressed():
	get_tree().quit()
