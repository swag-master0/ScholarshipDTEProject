extends CharacterBody3D


const SPEED = 8
const JUMP_VELOCITY = 8
const JUMP_FALLMULTIPLIER = 2
const TURN_VELOCITY = 10

@onready var character = $PlayerModel
@onready var pivot = $CameraPivot
@onready var cursor = $Cursor

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func GetMousePosition():
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var dropPlane = Plane(Vector3(0, 1, 0), character.global_position.y)
	var position3D = dropPlane.intersects_ray(camera.project_ray_origin(mousePos), camera.project_ray_normal(mousePos))
	return position3D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	cursor.global_position = GetMousePosition()

	#character.rotation.y = lerp_angle(character.rotation.y, atan2(-direction.x, -direction.z), delta * TURN_VELOCITY)
	character.look_at(Vector3(cursor.position.x, character.position.y + 1, cursor.position.z))
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	move_and_slide()