extends CharacterBody3D


const SPEED = 8
const JUMP_VELOCITY = 10
const JUMP_FALLMULTIPLIER = 5
const TURN_VELOCITY = 10

@onready var character = $PlayerModel
@onready var pivot = $CameraPivot
@onready var cursor = $Cursor

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD


func MousePosition():
	if  ready: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		var mousePos = get_viewport().get_mouse_position()
		var camera = get_tree().root.get_camera_3d()
	
		var dropPlane = Plane(Vector3(0, 1, 0), character.global_position.y)
		var position3D = dropPlane.intersects_ray(camera.project_ray_origin(mousePos), camera.project_ray_normal(mousePos))
		return position3D

func FetchObjects():
	if $Selection.body_entered(body):
		pass

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
	
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if !Input.is_action_pressed("click"):
			return #mouse released
	
		print("mouse held for 5 secs")

#func _on_selection_body_entered(body):
	#if body is RigidBody3D:
		#body.set_linear_velocity(cursor.global_position * 3)
	#var isCarrying = false
	#var carrypoint = $HoldPoint
	
	#if body is RigidBody3D:

			
			
			#body.reparent(carrypoint, false)
			
		#if not Input.is_action_pressed("click") and isCarrying == true:
		#	#carrypoint.remove_child(body)
		#	body.set_linear_velocity(cursor.global_position * 3)
		#	
		#	#isCarrying = false





