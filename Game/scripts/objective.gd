extends Node3D

@onready var objective = $ObjectiveItem
@export var nextscene : PackedScene
var player = null

"""
func _ready():
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			player = i
"""

func _on_level_start_body_entered(body):
	
	# if player finished level carrying the objective item
	if body.is_in_group("player"):
		if body.object == objective:
			ChangeScene()
	
	# if player finishes level with the objective item in the area
	if $LevelStart.get_overlapping_bodies().has(objective):
		for i in $LevelStart.get_overlapping_bodies():
			if i.is_in_group("player"):
				ChangeScene()
		


func ChangeScene():
	get_tree().change_scene_to_packed(nextscene)
