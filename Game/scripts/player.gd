extends CharacterBody3D

#TODO: This script desperately needs organising, because this piece of shit is a pain in the ass to read, let alone work on.


# INFO: PLAYER VARIABLES
@export var SPEED = 10
@export var JUMP_VELOCITY = 25
@export var JUMP_FALLMULTIPLIER = 5
@export var TURN_VELOCITY = 10

@export var PICKUP_RANGE = 6
@export var THROW_FORCE = 75
@export var MAX_FORCE = 2000
@export var PUSH_FORCE = 0.5
@export var CAM_FOLLOW_SPEED = 0.25


# INFO: NODE REFERENCES
@onready var character = $PlayerModel
@onready var pivot = $CentralCameraPoint
@onready var camera = $CentralCameraPoint/Camera3D
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D
@onready var scene_tree = get_tree()
@onready var info = $Info
@onready var invincibility_frames = $InvincibilityFrames


# INFO: HUD ELEMENTS
@onready var HUD = $HUD
@onready var hinttext = $HUD/Hints
@onready var hinttimer = $HUD/Hints/Timer

@onready var max_health = float(info.health)
@onready var initial_size = $HUD/HealthBar/HealthGreen.size.x



var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var object = null
var oldparent = null
var isHolding = false



# _physics_process() and _process() could be combined into a single function, but at the moment i dont give a shit
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if ready: # The fact I have to do this twice is utterly fucking retarded
		cursor.global_position = MousePosition()
	

	if (Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("backward")):
		faceDirection = Vector3(Input.get_action_strength("right") - Input.get_action_strength("left"), 0 ,Input.get_action_strength("backward") - Input.get_action_strength("forward")).normalized()
	
	if Input.is_action_pressed("click"):
		character.rotation.y = atan2(cursor.position.x, cursor.position.z)
		cursor.visible = true
	elif not Input.is_action_pressed("click"): # This is shitty code, but I fail to care
		character.rotation.y = lerp_angle(character.rotation.y, atan2(faceDirection.x, faceDirection.z), delta * TURN_VELOCITY)
		cursor.visible = false
		
		
	
	# quit to menu
	if Input.is_action_just_pressed("escape"):
		scene_tree.change_scene_to_file("res://scenes/levels/main_menu.tscn")
	
	
	
	# player movement from template (im too lazy to change it, nor do I need to)
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#TODO: find the reason why move_and_slide() keeps causing non-fatal errors. this shits getting annoying
	# it might not even be my fault. i don't know though.
	move_and_slide()
	
	
	#TODO: find a way to stop the collisions from bitching
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * PUSH_FORCE)
	

func _process(_delta):
	if NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE and isHolding == false:
		
		"""
		for i in NearestObject().get_children():
			if i is MeshInstance3D:
				$Cursor/MeshInstance3D.material.albedo_color = Color(1, 0, 0)
			else:
				$Cursor/MeshInstance3D.material.albedo_color = Color(0, 1, 0)
		"""
		
		if Input.is_action_just_pressed("click"): # handle picking up objects
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			object.global_transform = $PlayerModel/HoldPoint.global_transform
			object.reparent(character)
			object.set_freeze_enabled(true)
			object.set_collision_layer_value(1, false)
			object.set_collision_mask_value(1, false)
		else:
			pass
	
	
	
	
	"""
	if Input.is_action_just_pressed("click"): # handle picking up objects
		if NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE and isHolding == false:
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			object.global_transform = $PlayerModel/HoldPoint.global_transform
			object.reparent(character)
			object.set_freeze_enabled(true)
			object.set_collision_layer_value(1, false)
			object.set_collision_mask_value(1, false)
		else:
			pass
		"""
	if Input.is_action_just_released("click"): # handle throwing objects
		if object and isHolding == true:
			isHolding = false
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			var force = cursor.global_position - position
			force.y = force.y + 2
			force = force.clamp(Vector3(-MAX_FORCE, -MAX_FORCE, -MAX_FORCE), Vector3(MAX_FORCE, MAX_FORCE, MAX_FORCE))
			
			if character.position.distance_to(cursor.position) < 4 and character.position.distance_to(cursor.position) > -4:
				force = Vector3(0, 0, 0)
			
			
			object.apply_force(force * THROW_FORCE)
			
			object = null
	
	if ready: # handle health bar
		var health = float(info.health)
		var difference = float(max_health - health)
		var change = difference / max_health 
		
		var change_in_size = initial_size - (change * initial_size)
		$HUD/HealthBar/HealthGreen.size.x = change_in_size
	
	



# INFO: Fetches mouse position in 3D space
func MousePosition():
	if  ready: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		var mousePos = get_viewport().get_mouse_position()
		var spaceState = get_world_3d().direct_space_state
		
		var rayOrigin = camera.project_ray_origin(mousePos)
		var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
		var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		
		var rayArray = spaceState.intersect_ray(query)
		
		# TODO: Implement a way to lock on to enemies, because it could be quite hard to aim
		
		# if raycast hit something
		if rayArray.has("position"): 
			return rayArray["position"]
			
		
		# if raycast hit nothing, it draws a plane and sees where a raycast hits on that
		else:
			var dropPlane = Plane(Vector3(0, 1, 0), character.global_position.y)
			var position3D = dropPlane.intersects_ray(camera.project_ray_origin(mousePos), camera.project_ray_normal(mousePos))
			return position3D

func NearestObject():
	var objects = detection.get_overlapping_bodies()
	
	var closest_node = null
	var closest_node_distance = 0.0
	
	for i in objects:
		var current_node_distance = detection.global_position.distance_to(i.global_position)
		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance 
	
	if closest_node:
		return closest_node

func PlayerDeath():
	scene_tree.change_scene_to_file("res://scenes/levels/main_menu.tscn") # reset due to death

func _on_hitbox_body_entered(body):
	if body.is_in_group("enemy") and invincibility_frames.is_stopped():
		for i in range(body.get_children().size()):
			if body.get_children()[i].is_in_group("info"):
				var enemy_info = body.get_children()[i]
				var damage = enemy_info.damage
				
				info.health = info.health - damage
				invincibility_frames.start()
	
	if info.health <= 0:
		PlayerDeath()



# NOTICE: BELOW FUNCTIONS ARE TO DO WITH HUD OF PLAYER
func sendHintToPlayer(hint):
	hinttext.text = hint
	hinttimer.start()

func _hinttext_timeout():
	hinttext.text = ""
