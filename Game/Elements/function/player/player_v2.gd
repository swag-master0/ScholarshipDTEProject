extends CharacterBody3D

# INFO: PLAYER VARIABLES
@export_group("Player Variables")
@export_category("Tutorial")
@export var tutorial_mode : bool = false

@export_category("Preferences")
@export var SENSITIVITY : float = 0.25
@export var MAX_LOOK : float = 60
@export var MIN_LOOK : float = -75

@export_category("Gameplay")
@export var SPEED : float = 10
@export var JUMP_VELOCITY : float = 25
@export var JUMP_FALLMULTIPLIER : float = 5
@export var TURN_VELOCITY : float = 10
@export var PICKUP_RANGE : float = 6
@export var THROW_FORCE : float = 2000


# Player Model
@onready var character = $PlayerModel
@onready var holdpoint = $PlayerModel/HoldPoint
@onready var holdpoint_backup = $PlayerModel/HoldPoint/Backup
@onready var obstruction_detection = $PlayerModel/ObstructionDetector

# Camera
@onready var pivot = $CentralCameraPoint
@onready var camera = $CentralCameraPoint/Camera3D
@onready var ray = $CentralCameraPoint/Camera3D/RayCast3D

# Cursor
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D


# Info
@onready var info = $Info
@onready var max_health = info.health

# HUD
@onready var HUD = $HUD
@onready var hud_health = $HUD/Health
@onready var hud_healthwhite = $HUD/Health/HealthWhite
@onready var hud_enemyhealth = $HUD/EnemyHealth
@onready var hinttext = $HUD/Hints
@onready var hinttimer = $HUD/Hints/Timer
@onready var hud_dialogue = $HUD/Dialogue
@onready var hud_dialoguedelay = $HUD/Dialogue/DelayBetweenCharacters
@onready var hud_dialogueremove = $HUD/Dialogue/RemoveCharacters
@onready var pausemenu = $HUD/PauseMenu
@onready var deathscreen = $HUD/DeathScreen
@onready var hurtvfx = $HUD/HurtVFX
@onready var indicator = $HUD/Indicator
@onready var indicator_tutorial = $HUD/Indicator/AnimatedSprite2D
@onready var options_menu = $HUD/OptionsMenu
@onready var hud_levelcomplete = $HUD/LevelCompleted
@onready var hud_levelcomplete_delay = $HUD/LevelCompleted/Delay

# Audio
@onready var footstep_delay = $Audio/FootstepDelay
@onready var sound_footstep = $Audio/PlayerWalk
@onready var sound_select = $Audio/PlayerSelect
@onready var sound_hurt = $Audio/PlayerHurt
@onready var sound_dialogue = $Audio/Dialogue

# Animations
@onready var animations = $PlayerModel/AnimationPlayer


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var oldparent = null
var isHolding = false
var canPause = true
var selectionsound = false
var levelchangetriggered = false
var healthvisualindicator = false

var tutorial_pickup = false
var tutorial_proximitydrop = false
var tutorial_objective = false

var main_menu = "res://Elements/environments/misc/main_menu/main_menu.tscn"


# please leave object blank, but keep as export
@export_group("Programming Stuff")
@export var object : RigidBody3D
@export var level_completed : bool = false




func _ready():
	Engine.time_scale = 1
	canPause = true
	pausemenu.visible = false
	deathscreen.visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	animations.play("RESET")
	
	# the funny
	print_rich("[font_size=120][color=CORNFLOWER_BLUE][wave]heck you")


func _input(event):
	if event is InputEventMouseMotion and canPause == true:
		
		rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
		
		if !velocity and !isHolding:
			character.rotate_y(deg_to_rad(event.relative.x * SENSITIVITY))
		
		pivot.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(MIN_LOOK), deg_to_rad(MAX_LOOK))
		

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	MousePosition()
	
	
	
	if (Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("backward")):
		faceDirection = Vector3(Input.get_action_strength("right") - Input.get_action_strength("left"), 0 ,Input.get_action_strength("backward") - Input.get_action_strength("forward")).normalized()
	
	
	
	if isHolding:
		character.rotation.y = atan2(cursor.position.x, cursor.position.z)
	elif !isHolding and velocity:
		character.rotation.y = lerp_angle(character.rotation.y, atan2(faceDirection.x, faceDirection.z), delta * TURN_VELOCITY)
	elif !velocity:
		pass
		#print("no movement")
	
	#character.rotation.y = atan2(cursor.position.x, cursor.position.z)
	
	
	# player movement from template (im too lazy to change it, nor do I need to)
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if footstep_delay.is_stopped() and is_on_floor():
			footstep_delay.start()
			sound_footstep.pitch_scale = randf_range(75, 125) / 100
			sound_footstep.play()
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	

# process is the player throwing mechanic and healthbar code
func _process(_delta):
	# Handle picking up RIGID BODIES
	if (NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE) and isHolding == false:
		
		if NearestObject().is_in_group("ungrabbable"):
			return
		
		setCursorPosition(NearestObject().global_position, true)
		
		
		
		if Input.is_action_just_pressed("click"):
			sound_select.play()
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			holdpoint.position = Vector3(0, 1, 2)
			object.global_transform = holdpoint.global_transform
			object.reparent(character)
			object.set_freeze_enabled(true)
			object.set_collision_layer_value(1, false)
			object.set_collision_mask_value(1, false)
			
		else:
			pass
	
	
	if !Input.is_action_pressed("click"): 
		# check if the object exists still, or else crash
		if !is_instance_valid(object):
			object = null
			isHolding = false
		
		
		if object and isHolding == true and object is RigidBody3D:
			
			isHolding = false
			
			sound_select.play()
			
			object.set_freeze_enabled(false)
			object.reparent(oldparent)
			
			object.set_collision_layer_value(1, true)
			object.set_collision_mask_value(1, true)
			
			var force = (cursor.global_position - position).normalized()
			
			
			if character.position.distance_to(cursor.position) < 4 and character.position.distance_to(cursor.position) > -4:
				force = Vector3(0, 0, 0)
				#drop_indicator.visible = true
				
				if tutorial_mode and !tutorial_proximitydrop:
					tutorial_proximitydrop = true
					sendHintToPlayer("You can drop items gently when the cursor is over yourself")
			
			
			for i in obstruction_detection.get_overlapping_bodies():
				if i is StaticBody3D:
					object.global_position = holdpoint_backup.global_position
			
			
			object.apply_force(force * THROW_FORCE)
			
			object = null
		
	
	if ready: 
		var health = info.health
		
		hud_health.value = health
		hud_health.max_value = max_health
		hud_healthwhite.max_value = max_health
		
		if health == max_health:
			hud_health.visible = false
		else:
			hud_health.visible = true
		
		
		# visibly display damage on the player (this is stupid)
		var health_ratio : float = health / max_health
		var mat = character.get_active_material(0)
		mat.set_shader_parameter("health", health_ratio)
		
		
		
		if hud_healthwhite.value != hud_health.value and !healthvisualindicator:
			healthvisualindicator = true
			
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(hud_healthwhite, "value", health, 1)
			
			await tween.finished
			hud_healthwhite.value = hud_health.value
			
			healthvisualindicator = false
	
	
	if level_completed:
		Nextlevel()
	
	if !animations.is_playing():
		animations.play("RESET")
	
	if self.global_position.y <= -1000:
		DeathScreen()
	
	if Input.is_action_just_pressed("escape"):
		PauseMenu(true)





func MousePosition():
	if  ready and canPause: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		"""
		var mousePos = get_viewport().get_mouse_position()
		var spaceState = get_world_3d().direct_space_state
		
		var rayOrigin = camera.project_ray_origin(mousePos)
		var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
		var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		
		var rayArray = spaceState.intersect_ray(query)
		
		# if raycast hit something
		if rayArray.has("position"): 
			cursor.global_position = rayArray["position"]
			
			
		"""
		
		
		if ray.is_colliding() and is_instance_valid(ray.get_collider()):
			var rayHit = ray.get_collider()
			cursor.global_position = ray.get_collision_point()
			
			setCursorPosition(Vector3(), false)
			viewEnemyHealth(null, false)
			
			if rayHit.is_in_group("enemy"):
				for i in rayHit.get_children():
					if i.is_in_group("info"):
						if i.DisplayHealthBar == true:
							viewEnemyHealth(rayHit, true)
				
				
				
				if Input.is_action_pressed("click"):
					cursor.global_position = rayHit.global_position
					setCursorPosition(rayHit.global_position, true)
					
		

		else:
			cursor.global_position = ray.target_position + self.global_position



func NearestObject():
	var objects = detection.get_overlapping_bodies()
	
	var closest_node = null
	var closest_node_distance = 0.0
	
	# fetches closest node to the cursor
	for i in objects:
		var current_node_distance = detection.global_position.distance_to(i.global_position)
		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance 
	
	
	if closest_node:
		return closest_node


func _on_info_take_damage():
	animations.play("hurt")
	
	sound_hurt.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	sound_hurt.play(0)



func _on_info_death():
	$Audio/PlayerDeath.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	$Audio/PlayerDeath.play()
	DeathScreen()




func sendHintToPlayer(hint):
	hinttext.text = hint
	hinttimer.start()


func _hinttext_timeout():
	hinttext.text = ""
	
	if tutorial_pickup:
		tutorial_pickup = false


# INFO: DIALOGUE SYSTEM
# NOTE: This is probably gonna get removed
func Dialogue(dialogue : String, delay : float = 0.05):
	hud_dialogue.visible = true
	
	hud_dialogue.text = "[center]" + dialogue
	hud_dialoguedelay.wait_time = delay
	
	
	for i in dialogue.length():
		hud_dialogue.visible_characters = i + 1
		
		sound_dialogue.pitch_scale = randf_range(50, 150) / 100
		sound_dialogue.play()
		
		hud_dialoguedelay.start()
		await hud_dialoguedelay.timeout
		
		# restarts this timer after every character
		hud_dialogueremove.start()


func _on_remove_characters_timeout():
	hud_dialogue.visible = false
	hud_dialogue.text = ""




# INFO: LOCK-ON CURSOR AND ENEMY HEALTH BARS
func setCursorPosition(pos : Vector3, visibility : bool):
	
	if visibility:
		
		indicator.visible = true
		indicator.position = camera.unproject_position(pos) - indicator.size / 2
		
		
		if tutorial_mode:
			indicator_tutorial.visible = true
			
			if !tutorial_pickup:
				tutorial_pickup = true
				sendHintToPlayer("Use MOUSE 1 to pick up and throw objects")
		
		else:
			indicator_tutorial.visible = false
		
	
	elif !visibility:
		indicator.visible = false
		selectionsound = false


func viewEnemyHealth(enemy : Object, visibility : bool):
	var healthbar = hud_enemyhealth
	
	if visibility:
		
		healthbar.visible = true
		healthbar.position = (camera.unproject_position(enemy.global_position) - healthbar.size / 2) + Vector2(0, -50)
		
		for i in enemy.get_children():
			if i.is_in_group("info"):
				healthbar.value = i.health
				healthbar.max_value = i.max_health
	
	elif !visibility:
		healthbar.visible = false






func RestartLevel():
	get_tree().paused = false
	get_tree().reload_current_scene()


func QuitToMenu():
	get_tree().paused = false
	Engine.time_scale = 1
	get_tree().change_scene_to_file(main_menu)





func PauseMenu(toggle : bool):
	if canPause == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = toggle
		pausemenu.visible = toggle
		
		if toggle == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_button_pressed():
	PauseMenu(false)


func _on_restart_button_pressed():
	RestartLevel()


func _on_quit_button_pressed():
	QuitToMenu()


func _on_options_button_pressed():
	options_menu.visible = true






func DeathScreen():
	canPause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0, 0.2)
	
	deathscreen.visible = true



func _on_death_restart_button_pressed():
	RestartLevel()


func _on_death_quit_button_pressed():
	QuitToMenu()



func Nextlevel():
	if levelchangetriggered == false:
		levelchangetriggered = true
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_tree().paused = true
		
		hud_levelcomplete.visible = true
		hud_levelcomplete_delay.start()

# change level after desired time elapsed
func _on_delay_timeout():
	get_tree().paused = false
	
	
	for i in self.get_parent().get_children():
		if i.is_in_group("objective_start"):
			#get_tree().change_scene_to_packed(i.nextscene)
			get_tree().change_scene_to_file(i.nextscene_string)



# <-- This number is the amount of times I have lost the will to live
