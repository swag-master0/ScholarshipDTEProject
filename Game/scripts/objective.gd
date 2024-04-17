extends Node3D

@onready var objective = $ObjectiveItem
@export var nextscene = "res://scenes/levels/main_menu.tscn"

func _on_level_start_body_entered(body):
	if body == objective:
		get_tree().change_scene_to_file(nextscene)
