extends Area3D

@export var nextscene : PackedScene
@export var nextscene_string : String = "res://Elements/function/main_menu.tscn"

var player = null

var player_colliding = false
var objective_colliding = false


func _process(_delta):
	if player_colliding and objective_colliding:
		ChangeScene()
	
	for i in self.get_overlapping_bodies():
		if i.is_in_group("player"):
			i.velocity.y += 1.5


func _on_body_entered(body):
	if body.is_in_group("player") and ready:
		player_colliding = true
		
		if is_instance_valid(body.object) and body.object.is_in_group("objective"):
			ChangeScene()
	
	if body.is_in_group("objective"):
		objective_colliding = true
	


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_colliding = false
	
	if body.is_in_group("objective"):
		objective_colliding = false
	


func ChangeScene():
	var objects_to_save = []
	
	for i in self.get_overlapping_bodies():
		if i is RigidBody3D:
			
			# Save each object as it's own PackedScene, to save mesh data and all children of each object
			# Otherwise, children of the RigidBody do not save so the RigidBody has no CollisionShape or MeshInstance
			
			var ObjectToSave = i.duplicate()
			var packed = PackedScene.new()
			
			for c in ObjectToSave.get_children():
				c.owner = ObjectToSave
			
			# check if the object is not a script, or else it causes a crash
			# this is a massive hack, but i don't care
			if !is_instance_valid(ObjectToSave):
				pass
			else:
				ObjectToSave.position = Vector3(0, 5, 0)
			
			packed.pack(ObjectToSave)
			objects_to_save.append(packed)
	
	var save = SaveGame.new()
	save.save_player_hub(objects_to_save, false)
	
	# this is to trigger the GUI screen for the player completing the level
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			i.level_completed = true







