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



func _physics_process(delta):
	# fall
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	var direction = Vector3()
	
	for i in self.get_parent_node_3d().get_children():
		
		if i is CharacterBody3D and i.is_in_group("player") and global_position.distance_to(i.global_position) < 5:
			var player = i
			
			raycast.target_position = player.global_position - global_position
			
			if raycast.get_collider() == player:
				nav.target_position = player.position
			
			else:
				pass
			
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
