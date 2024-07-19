extends Node3D



func _ready():
	var save = SaveGame.new()
	
	save.load_player_hub(self)


func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		var save = SaveGame.new()
		save.load_player_hub(self)



func save_hub_objects():
	var objects_to_save = []
	
	for i in get_children():
		if i is RigidBody3D:
			
			# Save each object as it's own PackedScene, to save mesh data and all children of each object
			# Otherwise, children of the RigidBody do not save so the RigidBody has no CollisionShape or MeshInstance
			
			var ObjectToSave = i.duplicate()
			var packed = PackedScene.new()
			
			for c in ObjectToSave.get_children():
				c.owner = ObjectToSave
			
			packed.pack(ObjectToSave)
			objects_to_save.append(packed)
			
			
		if i.is_in_group("player"):
			if i.object:
				var packed = PackedScene.new()
				
				for c in i.get_children():
					c.owner = i
				
				packed.pack(i)
				objects_to_save.append(i)
	
	
	
	var save = SaveGame.new()
	save.save_player_hub(objects_to_save)



func _on_portal_body_entered(body):
	save_hub_objects()
	
	if body.is_in_group("player"):
		body.Nextlevel()





