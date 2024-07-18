extends Node3D



func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var save = SaveGame.new()
		save.load_player_hub(self)



func save_hub_objects():
	var objects_to_save = []
	
	for i in get_children():
		if i is RigidBody3D:
			for c in i.get_children():
				c.set_owner(i)
			objects_to_save.append(i)
			
		if i.is_in_group("player"):
			if i.object:
				objects_to_save.append(i)
	
	
	
	var save = SaveGame.new()
	save.save_player_hub(objects_to_save)



func _on_portal_body_entered(body):
	save_hub_objects()
	
	if body.is_in_group("player"):
		body.Nextlevel()





