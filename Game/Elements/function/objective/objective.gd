extends Node3D

@export var nextscene : PackedScene
@export var nextscene_string : String = "res://Elements/environments/misc/main_menu/main_menu.tscn"
var player = null

var player_colliding = false
var objective_colliding = false


func _process(_delta):
	if player_colliding and objective_colliding:
		ChangeScene()
	


func _on_body_entered(body):
	if body.is_in_group("player") and ready:
		player_colliding = true
		
		if is_instance_valid(body.object) and body.object.is_in_group("objective"):
			ChangeScene()
	
	if body.is_in_group("objective"):
		objective_colliding = true
	
	# TODO
	"""
	for i in $LevelStart.get_overlapping_bodies():
		if i.is_in_group("player"):
			ChangeScene()
	"""


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_colliding = false
	
	if body.is_in_group("objective"):
		objective_colliding = false
	


func ChangeScene():
	# this is to trigger the GUI screen for the player completing the level
	print(self.get_parent())
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			i.level_completed = true







