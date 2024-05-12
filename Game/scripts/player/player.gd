extends CharacterBody3D

#TODO: This script desperately needs organising and annotating, because this piece of shit is a pain in the ass to read, let alone work on.


# INFO: PLAYER VARIABLES
@export var tutorial_mode : bool = false

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
@onready var deathscreen = $HUD/DeathScreen
@onready var hurtvfx = $HUD/HurtVFX

@onready var max_health = info.health


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var oldparent = null
var isHolding = false
var canPause = true
var selectionsound = false
var levelchangetriggered = false


# please leave object blank, but keep as export
@export var object : RigidBody3D
@export var level_completed : bool = false




# general stuff
func _ready():
	Engine.time_scale = 1
	canPause = true
	pausemenu.visible = false
	deathscreen.visible = false
	
	
	self.rotate_y(deg_to_rad(45))
	
	# the funny
	print_rich("[font_size=120][color=CORNFLOWER_BLUE][wave]heck you")

# physics_process is the player movement and 3D cursor stuff
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER
	if Input.is_action_pressed("jump") and is_on_floor():
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
		
		# Footstep
		if $FootstepDelay.is_stopped() and is_on_floor():
			$FootstepDelay.start()
			$Audio/PlayerWalk.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
			$Audio/PlayerWalk.play()
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#TODO: find the reason why move_and_slide() keeps causing non-fatal errors. this shits getting annoying
	# it might not even be my fault. i don't know though.
	move_and_slide()
	
	
	"""
	#TODO: find a way to stop the collisions from bitching
	for i in get_slide_collision_count():
		var collisions = get_slide_collision(i)
		if collisions.get_collider() is RigidBody3D:
			collisions.get_collider().apply_central_impulse(-collisions.get_normal() * PUSH_FORCE)
	"""

# process is the player throwing mechanic and healthbar code
func _process(_delta):
	# Handle picking up RIGID BODIES
	if (NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE) and isHolding == false:
		
		setCursorPosition(NearestObject().global_position, true)
		
		if Input.is_action_just_pressed("click"): # handle picking up objects
			$Audio/PlayerSelect.play()
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
	
	
	# Handle throwing RIGID BODIES
	if Input.is_action_just_released("click"): 
		
		# check if the object exists still
		if !is_instance_valid(object):
			object = null
			isHolding = false
		
		
		# Throw RIGID BODIES
		if object and isHolding == true and object is RigidBody3D:
			isHolding = false
			
			# TODO: must change
			$Audio/PlayerSelect.play()
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			var force = (cursor.global_position - position).normalized()
			
			# drop object gently
			# TODO: make a visual indicator for when this is true
			if character.position.distance_to(cursor.position) < 4 and character.position.distance_to(cursor.position) > -4:
				force = Vector3(0, 0, 0)
			
			
			object.apply_force(force * THROW_FORCE)
			
			object = null
		
	
	# handle health bar
	if ready: 
		var health = info.health
		
		$HUD/Health.value = health
		$HUD/Health.max_value = max_health
		
	
	if level_completed:
		Nextlevel()
	
	# quit to menu
	if Input.is_action_just_pressed("escape"):
		PauseMenu(true)





# INFO: Fetches mouse position in 3D space
func MousePosition():
	if  ready and canPause: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
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
		
		
		# display actual aiming location if obstructed
		collision.global_position = global_position
		collision.target_position = cursor.global_position - global_position
		
		if (collision.get_collision_point().distance_to(cursor.global_position) > 8) and Input.is_action_pressed("click"):
			$"3D-CursorModel".global_position = lerp($"3D-CursorModel".global_position, collision.get_collision_point(), 0.25)
			$"3D-CursorModel".visible = true
			$Cursor/Area3D/MeshInstance3D.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			$"3D-CursorModel".global_position = cursor.global_position
			$"3D-CursorModel".visible = false
			$Cursor/Area3D/MeshInstance3D.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# fetch closest object to the mouse position
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
	
	
	if closest_node:
		return closest_node

# triggers when player takes damage
func _on_info_take_damage():
	$AnimationPlayer.play("hurt")
	
	$Audio/PlayerHurt.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	$Audio/PlayerHurt.play()
	#hurtvfx.color = Color(1, 0, 0, 0.4)
	
	DamageVFX()
	pass

# triggers when player dies
func _on_info_death():
	$Audio/PlayerDeath.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	$Audio/PlayerDeath.play()
	DeathScreen()







# NOTICE: BELOW FUNCTIONS ARE TO DO WITH HUD OF PLAYER
func sendHintToPlayer(hint):
	hinttext.text = hint
	hinttimer.start()

func _hinttext_timeout():
	hinttext.text = ""


# INFO: DIALOGUE SYSTEM
func Dialogue(dialogue : String, delay : float = 0.05):
	$HUD/Dialogue.visible = true
	
	$HUD/Dialogue.text = "[center]" + dialogue
	$HUD/Dialogue/DelayBetweenCharacters.wait_time = delay
	
	
	for i in dialogue.length():
		print(i)
		$HUD/Dialogue.visible_characters = i + 1
		
		$Audio/Dialogue.pitch_scale = randf_range(50, 150) / 100
		$Audio/Dialogue.play()
		
		$HUD/Dialogue/DelayBetweenCharacters.start()
		await $HUD/Dialogue/DelayBetweenCharacters.timeout
		
		# restarts this timer after every character
		$HUD/Dialogue/RemoveCharacters.start()


func _on_remove_characters_timeout():
	$HUD/Dialogue.visible = false
	$HUD/Dialogue.text = ""




# INFO: LOCK-ON CURSOR AND ENEMY HEALTH BARS
func setCursorPosition(pos : Vector3, visibility : bool):
	var indicator = $HUD/Indicator
	
	if visibility:
		
		indicator.visible = true
		indicator.position = camera.unproject_position(pos) - indicator.size / 2
		
		
		if tutorial_mode:
			$HUD/Indicator/AnimatedSprite2D.visible = true
			sendHintToPlayer("Use MOUSE 1 to pick up and throw objects")
		else:
			$HUD/Indicator/AnimatedSprite2D.visible = false
		
	
	elif !visibility:
		indicator.visible = false
		selectionsound = false


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





# INFO: these functions are called when menu buttons in pause menu and death screen are pressed
func RestartLevel():
	get_tree().paused = false
	get_tree().reload_current_scene()


func QuitToMenu():
	get_tree().paused = false
	Engine.time_scale = 1
	scene_tree.change_scene_to_file("res://scenes/levels/main_menu.tscn")





# INFO: PAUSE MENU 
func PauseMenu(toggle : bool):
	if canPause == true:
		get_tree().paused = toggle
		pausemenu.visible = toggle

# Opens Pause Menu
func _on_resume_button_pressed():
	PauseMenu(false)

# Restart Button pressed in pause menu
func _on_restart_button_pressed():
	RestartLevel()

# Quit Button pressed in pause menu
func _on_quit_button_pressed():
	QuitToMenu()






# INFO: DEATH
func DeathScreen():
	
	
	canPause = false
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0, 0.2)
	
	deathscreen.visible = true
	#get_tree().paused = true
	#Engine.time_scale = lerp(1, 0, 0.1)


# Restart Button pressed in death screen
func _on_death_restart_button_pressed():
	RestartLevel()

# Quit Button pressed in death screen
func _on_death_quit_button_pressed():
	QuitToMenu()


func DamageVFX():
	pass
	# TODO : tween the visual effects appearing
	"""
	
	var colour = hurtvfx.color
	colour.lerp(Color(0, 0, 0, 0), 1)
	
	
	hurtvfx.color = colour
	
	
	var tween = create_tween()
	tween.tween_property(Color(hurtvfx.color), "a", 0.4, 1)
	
	
	hurtvfx.color.lerp(Color(0, 0, 0, 0), 0.1)
	
	print(Color(hurtvfx.color))
	
	"""




# INFO: LEVEL COMPLETE AND CHANGE
func Nextlevel():
	if levelchangetriggered == false:
		levelchangetriggered = true
		
		get_tree().paused = true
		
		$HUD/LevelCompleted.visible = true
		$HUD/LevelCompleted/Delay.start()

# change level after desired time elapsed
func _on_delay_timeout():
	get_tree().paused = false
	
	for i in self.get_parent().get_children():
		if i.is_in_group("objective"):
			get_tree().change_scene_to_packed(i.nextscene)



# <-- This number is the amount of times I have lost the will to live
