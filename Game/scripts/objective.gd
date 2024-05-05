extends Node3D

@onready var objective = $ObjectiveItem
@export var nextscene : PackedScene


func _on_level_start_body_entered(body):
	if body == objective:
		ChangeScene()
	
	if body.is_in_group("player"):
		if body.object == objective:
			ChangeScene()


func ChangeScene():
	get_tree().change_scene_to_packed(nextscene)
