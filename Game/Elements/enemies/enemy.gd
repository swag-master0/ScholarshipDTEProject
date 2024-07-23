extends CharacterBody3D

@export var speed = 6
@export var accel = 10
@export var damage = 3
@export var light_based : bool = false

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var raycast = $RayCast3D
@onready var coll = $CollisionShape3D

@onready var info = $Info
@onready var health = info.health

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# navigating
func _physics_process(delta):
	var direction = Vector3()
	
	if ready:
		for i in range(self.get_parent_node_3d().get_children().size()):
			
			if self.get_parent_node_3d().get_children()[i] is CharacterBody3D and self.get_parent_node_3d().get_children()[i].is_in_group("player") and !$AnimationPlayer.is_playing():
				var player = self.get_parent_node_3d().get_children()[i]
				
				if light_based and ready:
					nav.target_position = player.position
					
				
				elif !light_based:
					raycast.target_position = player.global_position - global_position
				
					if raycast.get_collider() == player:
						nav.target_position = player.position
				
				else:
					pass
	
	
	raycast.global_position = global_position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if $AttackDelay.is_stopped():
		velocity = velocity.lerp(direction * speed, accel * delta)
	else:
		velocity = Vector3(0, 0, 0)
	
	
	if not is_on_floor():
		velocity.y -= gravity * delta * 10
	
	for i in $SoftPush.get_overlapping_bodies():
		if (i.is_in_group("enemy") and i != self):
			var difference = i.global_position - self.global_position
			velocity -= difference
	
	# literally only for c2_m4, since i'm too lazy to create a whole new enemy for a gimick
	if light_based:
		for i in $SoftPush.get_overlapping_areas():
			if i.is_in_group("light"):
				var difference = i.global_position - self.global_position
				velocity -= difference
	
	
	move_and_slide()
	
	if $AttackDelay.is_stopped():
		$Mesh.rotation.y = lerp_angle($Mesh.rotation.y, atan2(direction.x, direction.z), delta * 25)
	
	
	for i in $Mesh/Detection.get_overlapping_bodies():
		if i.is_in_group("player") and $AttackDelay.is_stopped():
			$AnimationPlayer.play("attack")
			$AttackDelay.start()
	
	
	
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * 0.5)


# hurt player
func _on_hit_detector_body_entered(body):
	if body.is_in_group("player"):
		
		for i in body.get_children():
			if i.is_in_group("info"):
				i.Damage(damage)
			



func _on_info_take_damage():
	$AnimationPlayer.play("hurt")


func _on_info_death():
	self.queue_free()





