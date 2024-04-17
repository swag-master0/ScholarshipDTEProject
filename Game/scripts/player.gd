extends CharacterBody3D

@export var SPEED = 10
@export var JUMP_VELOCITY = 25
@export var JUMP_FALLMULTIPLIER = 5
@export var TURN_VELOCITY = 10

@export var PICKUP_RANGE = 6
@export var THROW_FORCE = 75
@export var MAX_FORCE = 2000
@export var PUSH_FORCE = 10

@onready var character = $PlayerModel
@onready var pivot = $CentralCameraPoint
@onready var camera = $CentralCameraPoint/Camera3D
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var object = null
var oldparent = null
var isHolding = false


func MousePosition():
	if  ready: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		var mousePos = get_viewport().get_mouse_position()
		var cam = get_tree().root.get_camera_3d()
		
		var dropPlane = Plane(Vector3(0, 1, 0), character.global_position.y)
		var position3D = dropPlane.intersects_ray(cam.project_ray_origin(mousePos), cam.project_ray_normal(mousePos))
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

func _ready():
	rotate_x(deg_to_rad(5))

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
	elif not Input.is_action_pressed("click"): # This is shitty code, but I fail to care
		character.rotation.y = lerp_angle(character.rotation.y, atan2(faceDirection.x, faceDirection.z), delta * TURN_VELOCITY)
	
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("scroll_down"):
		pivot.rotation.x = deg_to_rad(45)
	if Input.is_action_just_pressed("scroll_up"):
		pivot.rotation.x = deg_to_rad(15)
	
	
	
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	
	#TODO: find a way to stop the collisions from bitching
	"""
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * PUSH_FORCE)
	"""	

func _process(_delta):
	if Input.is_action_just_pressed("click"):
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
		
	if Input.is_action_just_released("click"):
		if object and isHolding == true:
			print(object)
			isHolding = false
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			var force = cursor.global_position - position
			force.y = force.y + 4
			force = force.clamp(Vector3(-MAX_FORCE, -MAX_FORCE, -MAX_FORCE), Vector3(MAX_FORCE, MAX_FORCE, MAX_FORCE))
			
			if character.position.distance_to(cursor.position) < 4 and character.position.distance_to(cursor.position) > -4:
				force = Vector3(0, 0, 0)
			
			
			object.apply_force(force * THROW_FORCE)
			print(character.position.distance_to(cursor.position))
			
			object = null
	

