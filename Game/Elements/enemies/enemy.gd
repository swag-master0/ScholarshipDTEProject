extends CharacterBody3D

@export var speed = 9
@export var accel = 10
@export var damage = 3
@export var light_based : bool = false

@export var CAN_DEAL_DAMAGE: bool = false

@onready var nav : NavigationAgent3D = $NavigationAgent3D
@onready var raycast = $RayCast3D
@onready var coll = $CollisionShape3D

@onready var info = $Info
@onready var health = info.health

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _process(_delta):
	if CAN_DEAL_DAMAGE:
		for i in $HitArea.get_overlapping_bodies():
			if i.is_in_group("player"):
				
				for c in i.get_children():
					if c.is_in_group("info"):
						c.Damage(damage)
	
	if velocity and !($spider/AnimationPlayer.current_animation == "attack"):
		$spider/AnimationPlayer.play("walk")
	elif !velocity and !($spider/AnimationPlayer.current_animation == "attack"):
		$spider/AnimationPlayer.play("idle")



# navigating
func _physics_process(delta):
	var direction = Vector3()
	
	if ready:
		for i in self.get_parent_node_3d().get_children():
			
			if i is CharacterBody3D and i.is_in_group("player"):# and !$AnimationPlayer.is_playing():
				var player = i
				
				if light_based and ready:
					nav.target_position = player.position
					
				
				elif !light_based:
					raycast.target_position = player.global_position - global_position
				
					if raycast.get_collider() == player:
						nav.target_position = player.position
				
	
	
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
		#$spider.rotation.y = lerp_angle($spider.rotation.y, atan2(direction.x, direction.z), delta * 25)
		rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), delta * 25)
	
	
	for i in $HitArea.get_overlapping_bodies():
		if i.is_in_group("player") and $AttackDelay.is_stopped():
			$spider/AnimationPlayer.play("attack")
			$HitTiming.play("hit_timing")
			
			$AttackDelay.start()
	
	
	# push rigid bodies
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * 0.5)



func _on_info_take_damage():
	pass


func _on_info_death():
	self.queue_free()










