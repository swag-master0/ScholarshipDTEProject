extends CharacterBody3D

@export var speed : float = 20

@onready var raycast = $RayCast3D
@onready var nav = $NavigationAgent3D

"""
@onready var mesh = $MeshInstance3D
@onready var coll = $CollisionShape3D
@onready var info = $Info
"""


var direction = Vector3()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ready:
		# gravity 
		if not is_on_floor():
			velocity.y -= gravity * delta
		
		
		
		# set raycast target position to the player's position
		for i in self.get_parent().get_children():
			if i.is_in_group("player") and i is CharacterBody3D:
				raycast.target_position = i.position - position
			#= player.global_position - global_position
		
		
		
		
		
		# player gets close enough for copycat to attack
		if raycast.get_collider() and raycast.get_collider().is_in_group("player") and raycast.get_collider().global_position.distance_to(self.global_position) < 5 and $Timer.is_stopped():
			nav.target_position = self.global_position + raycast.target_position
			$Timer.start()
		
		# player is within view of copycat
		elif raycast.get_collider() and raycast.get_collider().is_in_group("player") and raycast.get_collider().global_position.distance_to(self.global_position) > 5:
			nav.target_position = self.global_position		
		
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * speed, 10 * delta)
		
		
		if direction:
			$MeshInstance3D.rotation.y = atan2(direction.x, direction.z)
			$CollisionShape3D.rotation.y = atan2(direction.x, direction.z)
			$Info.rotation.y = atan2(direction.x, direction.z)
		
		
		move_and_slide()


func _on_info_death():
	if ready:
		# create a rigid body of itself upon death
		var rigidbody = $RigidBody3D
		rigidbody.set_freeze_enabled(false)
		
		var mesh = $MeshInstance3D
		mesh.reparent(rigidbody)
		
		var collision = $CollisionShape3D
		collision.reparent(rigidbody)
		
		rigidbody.reparent(self.get_parent())
		
		
		# delete self upon death
		self.queue_free()


func _on_info_take_damage():
	pass # Replace with function body.
