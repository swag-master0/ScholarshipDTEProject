extends CharacterBody3D

@export var speed = 2
@export var accel = 10
@export var damage = 5

@export var explosion : PackedScene 

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var raycast = $RayCast3D
@onready var mesh = $MeshInstance3D
@onready var coll = $CollisionShape3D
@onready var push = $SoftPush

@onready var info = $Info
@onready var health = info.health

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# navigating
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
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
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta * 10
	
	for i in push.get_overlapping_bodies():
		if (i.is_in_group("enemy") and i != self):
			var difference = i.global_position - self.global_position
			velocity -= difference
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * 0.5)


func _on_info_take_damage():
	speed = 0
	$AnimationPlayer.play("buildup")
	$Buildup.play(1)
	$Delay.start()

func _on_info_death():
	speed = 0
	$AnimationPlayer.play("buildup")
	$Buildup.play(1)
	$Delay.start()

func _on_body_entered(body):
	if body is CharacterBody3D and body.is_in_group("player"):
		speed = 0
		$AnimationPlayer.play("buildup")
		$Buildup.play(1)
		$Delay.start()




func _on_delay_timeout():
	var created_explosion = explosion.instantiate()
	self.get_parent().add_child(created_explosion)
	created_explosion.position = position
	
	self.queue_free()



