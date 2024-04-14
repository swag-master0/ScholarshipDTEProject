extends CharacterBody3D


const SPEED = 8
const JUMP_VELOCITY = 25
const JUMP_FALLMULTIPLIER = 5
const TURN_VELOCITY = 10

@onready var character = $PlayerModel
@onready var pivot = $CentralCameraPoint
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var object = null
var oldparent = null
var isHolding = false
var throwforce = 200
var maxforce = 2000


func MousePosition():
	if  ready: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		var mousePos = get_viewport().get_mouse_position()
		var camera = get_tree().root.get_camera_3d()
		
		
		
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
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		if NearestObject() and NearestObject() is RigidBody3D and isHolding == false:
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			#object.position = Vector3(character.global_position.x, character.global_position.y + 0.5, character.global_position.z - 3)
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
			
			var throw = Vector3(cursor.global_position.x * throwforce, cursor.global_position.y, cursor.global_position.z * throwforce)
			#aprint(throw.clamp(Vector3(-maxforce, -maxforce, -maxforce), Vector3(maxforce, maxforce, maxforce)))
			
			print(cursor.global_position)
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			#object.apply_force(throw.clamp(Vector3(-maxforce, -maxforce, -maxforce), Vector3(maxforce, maxforce, maxforce)) + position)
			object.apply_impulse(cursor.global_position)
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			object = null
	
	
	

