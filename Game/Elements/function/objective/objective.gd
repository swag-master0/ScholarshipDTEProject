extends Node3D


@onready var objective = $ObjectiveItem
@onready var initial_pos = $ObjectiveItem.global_position

@onready var pointer = $LevelStart/Pointer

@export var nextscene : PackedScene
var player = null


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
	# fetches the player in the scene, and triggers the level end sequence within the player
	# this is to also trigger the GUI screen for the player completing the level
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			i.level_completed = true



# anti softlock, in case the objective item falls out of the world
func _process(_delta):
	if objective.global_position.y < -500:
		objective.global_position = initial_pos
		objective.set_freeze_enabled(true)
		objective.set_freeze_enabled(false)
		
		push_error("Reset the location of the objective item, due to potential softlock")
	
	if objective.get_parent().get_parent().is_in_group("player"):
		pointer.visible = true
	else:
		pointer.visible = false



