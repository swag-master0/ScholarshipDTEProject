extends Node3D

signal ObjectBurnt

var incinerator_active : bool = false
@onready var incinerator = $Incinerator
@onready var incinerator_anim = $Incinerator/AnimationPlayer



func _ready():
	var save = SaveCell.new()
	
	await get_tree().create_timer(1).timeout
	
	save.load_cell(self)
	
	#animation_player.play("open")
	#animation_player.play("open", -1, -1, true) to play it backwards
	


func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		save_hub_objects()
	



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
	
	
	
	var save = SaveCell.new()
	save.save_cell(objects_to_save)



func _on_portal_body_entered(body):
	#if body is RigidBody3D:
	#	body.queue_free()
	
	save_hub_objects()
	
	if body.is_in_group("player"):
		body.Nextlevel()


func ActivateIncinerator(type: bool):
	if type:
		incinerator_active = true
		incinerator.visible = true
		incinerator_anim.play("open")
		$Incinerator/Audio/Idle.play()
		# activate incinerator
	elif !type:
		incinerator_anim.play_backwards("open")
		
		await get_tree().create_timer(3).timeout
		incinerator_active = false
		incinerator.visible = false
		$Incinerator/Audio/Idle.stop()
		# deactivate incinerator



func _on_incinerator_body_entered(body):
	if incinerator_active:
		if body.is_in_group("player"):
			for i in body.get_children():
				if i.is_in_group("info"):
					i.Damage(99999)
		
		if body is RigidBody3D:
			$Incinerator/Audio/Burn.play()
			ObjectBurnt.emit(body)
			body.queue_free()
