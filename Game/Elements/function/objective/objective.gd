extends Node3D

@export var nextscene : PackedScene
@export var nextscene_string : String = "res://Elements/environments/misc/main_menu/main_menu.tscn"
var player = null



func _on_body_entered(body):
	if body.is_in_group("player"):
		if is_instance_valid(body.object) and body.object.is_in_group("objective"):
			ChangeScene()
	
	# TODO
	"""
	for i in $LevelStart.get_overlapping_bodies():
		if i.is_in_group("player"):
			ChangeScene()
	"""


func ChangeScene():
	# this is to trigger the GUI screen for the player completing the level
	print(self.get_parent())
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			i.level_completed = true





