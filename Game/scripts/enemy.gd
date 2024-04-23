extends CharacterBody3D

@export var speed = 5
@export var accel = 10
@export var damage = 5

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var raycast = $RayCast3D
@onready var mesh = $MeshInstance3D
@onready var coll = $CollisionShape3D

@onready var info = $Info
@onready var health = info.health



# navigating
func _physics_process(_delta):	
	var direction = Vector3()
	
	for i in range(self.get_parent_node_3d().get_children().size()):
		
		if self.get_parent_node_3d().get_children()[i] is CharacterBody3D and self.get_parent_node_3d().get_children()[i].is_in_group("player"):
			var player = self.get_parent_node_3d().get_children()[i]
			
			raycast.target_position = player.global_position - global_position
			
			if raycast.get_collider() == player:
				nav.target_position = player.position
			
			else:
				pass
			
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * _delta)
	
	move_and_slide()


func _on_hitbox_body_entered(body):
	# when enemy is hit by prop
	if body is RigidBody3D:
		info.Damage(info.calculateDamageBasedOnVelocity(body))
		
		print(info.calculateDamageBasedOnVelocity(body))
	
	# when character hits player
	if body is CharacterBody3D and body.is_in_group("player"):
		#find info node and damage it
		for i in body.get_children():
			if i.is_in_group("info"):
				i.Damage(damage)


func _on_info_death():
	self.queue_free()






