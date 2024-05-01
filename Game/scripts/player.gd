extends CharacterBody3D

#TODO: This script desperately needs organising and annotating, because this piece of shit is a pain in the ass to read, let alone work on.


# INFO: PLAYER VARIABLES
@export var SPEED = 10
@export var JUMP_VELOCITY = 25
@export var JUMP_FALLMULTIPLIER = 5
@export var TURN_VELOCITY = 10

@export var PICKUP_RANGE = 6
@export var THROW_FORCE = 2000
@export var MAX_FORCE = 2000
@export var PUSH_FORCE = 0.5
@export var CAM_FOLLOW_SPEED = 0.25


# INFO: NODE REFERENCES
@onready var character = $PlayerModel
@onready var camera = $CentralCameraPoint/Camera3D
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D
@onready var scene_tree = get_tree()
@onready var info = $Info
@onready var collision = $PlayerModel/CollisionDetection


# INFO: HUD ELEMENTS
@onready var HUD = $HUD
@onready var hinttext = $HUD/Hints
@onready var hinttimer = $HUD/Hints/Timer
@onready var pausemenu = $HUD/PauseMenu


@onready var max_health = info.health




var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var object = null
var oldparent = null
var isHolding = false

# general stuff
func _ready():
	pausemenu.visible = false
	self.rotate_y(deg_to_rad(45))
	
	# the funny
	print_rich("[font_size=120][color=CORNFLOWER_BLUE][wave]heck you")


# _physics_process() and _process() could be combined into a single function, but at the moment i dont give a shit
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	MousePosition()
	
	if (Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("backward")):
		faceDirection = Vector3(Input.get_action_strength("right") - Input.get_action_strength("left"), 0 ,Input.get_action_strength("backward") - Input.get_action_strength("forward")).normalized()
	
	if Input.is_action_pressed("click"):
		character.rotation.y = atan2(cursor.position.x, cursor.position.z)
	elif not Input.is_action_pressed("click"): # This is shitty code, but I fail to care
		character.rotation.y = lerp_angle(character.rotation.y, atan2(faceDirection.x, faceDirection.z), delta * TURN_VELOCITY)
		
		
	
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
	# Handle picking up RIGID BODIES
	if (NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE) and isHolding == false:
		
		setCursorPosition(NearestObject().global_position, true)
		
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
	
	# Handle picking up PROJECTILES
	elif NearestObject() and NearestObject().is_in_group("projectile") and isHolding == false:
		

		setCursorPosition(NearestObject().global_position, true)
		
		if Input.is_action_just_pressed("click"): # handle picking up objects
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			object.global_transform = $PlayerModel/HoldPoint.global_transform
			object.reparent(character)
			object.Shoot(Vector3())
			object.iscarried = true
			object.set_collision_layer_value(1, false)
			object.set_collision_mask_value(1, false)
			
		else:
			pass
	
	
	# Handle throwing RIGID BODIES and PROJECTILES
	if Input.is_action_just_released("click"): 
		# Throw RIGID BODIES
		
		if object and isHolding == true and object is RigidBody3D:
			isHolding = false
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			var force = (cursor.global_position - position).normalized()
			
			# drop object gently
			if character.position.distance_to(cursor.position) < 4 and character.position.distance_to(cursor.position) > -4:
				force = Vector3(0, 0, 0)
			
			
			object.apply_force(force * THROW_FORCE)
			
			object = null
		
		# Throw PROJECTILES
		elif object and object.is_in_group("projectile") and isHolding == true:
			isHolding = false
			
			object.reparent(oldparent)
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			object.iscarried = false
			object.Shoot(cursor.global_position - object.global_position)
			
			object = null
	
	# handle health bar
	if ready: 
		var health = info.health
		
		$HUD/Health.value = health
		$HUD/Health.max_value = max_health
		
	
	
	# quit to menu
	if Input.is_action_just_pressed("escape"):
		PauseMenu(true)



# INFO: Fetches mouse position in 3D space
func MousePosition():
	if  ready: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		var mousePos = get_viewport().get_mouse_position()
		var spaceState = get_world_3d().direct_space_state
		
		var rayOrigin = camera.project_ray_origin(mousePos)
		var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
		var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		
		var rayArray = spaceState.intersect_ray(query)
		
		# if raycast hit something
		if rayArray.has("position"): 
			cursor.global_position = rayArray["position"]
			
			setCursorPosition(Vector3(), false)
			viewEnemyHealth(null, false)
		
		
		# lock onto enemy
		if rayArray.has("collider"):
			if rayArray["collider"].is_in_group("enemy"):
				viewEnemyHealth(rayArray["collider"], true)
				
				if Input.is_action_pressed("click"):
					cursor.global_position = rayArray["collider"].global_position
					setCursorPosition(rayArray["collider"].global_position, true)
				
		
		
		# if raycast hit nothing, it draws a plane and sees where a raycast hits on that
		else:
			var dropPlane = Plane(Vector3(0, 1, 0), character.global_position.y)
			var position3D = dropPlane.intersects_ray(camera.project_ray_origin(mousePos), camera.project_ray_normal(mousePos))
			cursor.global_position = position3D
			
			setCursorPosition(Vector3(), false)
			viewEnemyHealth(null, false)
		
		
		# display actual facing location if obstructed
		collision.global_position = global_position
		collision.target_position = cursor.global_position - global_position
		
		if (collision.get_collision_point().distance_to(cursor.global_position) > 8) and Input.is_action_pressed("click"):
			$"3D-CursorModel".global_position = lerp($"3D-CursorModel".global_position, collision.get_collision_point(), 0.25)
			$"3D-CursorModel".visible = true
			$Cursor/Area3D/MeshInstance3D.visible = true
		else:
			$"3D-CursorModel".global_position = cursor.global_position
			$"3D-CursorModel".visible = false
			$Cursor/Area3D/MeshInstance3D.visible = false


func NearestObject():
	var objects = detection.get_overlapping_bodies()
	
	var closest_node = null
	var closest_node_distance = 0.0
	
	var radius = $ProjectilePickupRange.get_overlapping_bodies()
	
	# fetches closest node to the cursor
	for i in objects:
		var current_node_distance = detection.global_position.distance_to(i.global_position)
		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance 
	
	# checks if any projectiles are near the player that take priority
	for i in radius:
		if i.is_in_group("projectile"):
			closest_node = i
			closest_node_distance = 0
	
	
	if closest_node:
		return closest_node


# triggers when player takes damage
func _on_info_take_damage():
	#print(info.health)
	pass

# triggers when player dies
func _on_info_death():
	#replace later with death scene and gameover screen
	scene_tree.change_scene_to_file("res://scenes/levels/main_menu.tscn")



# NOTICE: BELOW FUNCTIONS ARE TO DO WITH HUD OF PLAYER
func sendHintToPlayer(hint):
	hinttext.text = hint
	hinttimer.start()

func _hinttext_timeout():
	hinttext.text = ""


func PauseMenu(toggle : bool):
	get_tree().paused = toggle
	pausemenu.visible = toggle


func _on_resume_button_pressed():
	PauseMenu(false)


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().paused = false
	scene_tree.change_scene_to_file("res://scenes/levels/main_menu.tscn")


func setCursorPosition(pos : Vector3, visibility : bool):
	var indicator = $HUD/Indicator
	
	if visibility:
		
		indicator.visible = true
		indicator.position = camera.unproject_position(pos) - indicator.size / 2
	
	elif !visibility:
		indicator.visible = false

func viewEnemyHealth(enemy : Object, visibility : bool):
	var healthbar = $HUD/EnemyHealth
	
	if visibility:
		
		healthbar.visible = true
		healthbar.position = (camera.unproject_position(enemy.global_position) - healthbar.size / 2) + Vector2(0, -50)
		
		for i in enemy.get_children():
			if i.is_in_group("info"):
				healthbar.value = i.health
				healthbar.max_value = i.max_health
	
	elif !visibility:
		healthbar.visible = false




