extends Node3D


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
	print("play button clicked")

func _on_quit_button_pressed():
	get_tree().quit()
