extends CharacterBody3D

@export var speed = 20
@export var accel = 10
@export var damage = 10

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var raycast = $RayCast3D
@onready var mesh = $MeshInstance3D
@onready var coll = $CollisionShape3D

@onready var info = $Info
@onready var health = info.health

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction = Vector3()
var player = null

# INFO:
# true means the copycat will hide and attack the player when they get near
# false means they will run away and re-hide from the player
var behaviorstate = true


# main behavior
func _physics_process(delta):
	# fall
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	# set raycast position on the player
	for i in self.get_parent_node_3d().get_children():
		if (i is CharacterBody3D) and (i.is_in_group("player")) and (behaviorstate == true):
			player = i
			raycast.target_position = player.global_position - global_position
			
	
	
	# set target position to the player's position if the player is close enough
	if (raycast.get_collider() == player) and (global_position.distance_to(player.global_position) <= 5):
		nav.target_position = player.position
	
	else:
		pass
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	

	velocity = velocity.lerp(direction * speed, accel * delta)
	mesh.rotation.y = atan2(direction.x, direction.z)
	coll.rotation.y = atan2(direction.x, direction.z)
	info.rotation.y = atan2(direction.x, direction.z)
	
	
	move_and_slide()
	
	





# if game hit player
func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		behaviorstate = false
		$Timer.start()
		
		"""
		# TODO: should replace with a better way to run away from player
		var target_position = Vector3(randf_range(-500, 500), randf_range(-500, 500), randf_range(-500, 500))
		
		var closest_pos = NavigationServer3D.map_get_closest_point(get_world_3d().get_navigation_map(), target_position)
		nav.target_position = closest_pos
		"""


# reset to 
func _on_timer_timeout():
	behaviorstate = true
	nav.target_position = Vector3()



func _on_info_take_damage():
	pass


# replace self with rigidbody upon death
func _on_info_death():
	print_rich("[rainbow]copycat died lmao")
	# create a rigid body of itself upon death
	var rigidbody = $RigidBody3D
	rigidbody.disable_mode = false
	
	var mesh = $MeshInstance3D
	mesh.reparent(rigidbody)
	
	var collision = $CollisionShape3D
	collision.reparent(rigidbody)
	
	rigidbody.reparent(self.get_parent())
	
	
	# delete self upon death
	self.queue_free()
	









