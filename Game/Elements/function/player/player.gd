extends CharacterBody3D

func TOP():
	pass 
	# Literally only here so I have an easier way getting around function hell.
	# Click top in the methods list, and you're at the variables


#region INFO: PLAYER VARIABLES
@export_group("Player Variables")
@export_category("Tutorial")
@export var tutorial_mode : bool = false

@export_category("Preferences")
@export var SENSITIVITY : float = 0.25
@export var MAX_LOOK : float = 55
@export var MIN_LOOK : float = -75

@export_category("Gameplay")
@export var SAVE_GAME : bool = true
@export var SPEED : float = 10
@export var JUMP_VELOCITY : float = 35
@export var JUMP_FALLMULTIPLIER : float = 10
@export var TURN_VELOCITY : float = 50
@export var PICKUP_RANGE : float = 6
@export var THROW_FORCE : float = 500

@export_category("Visuals")
@export var DISPLAY_DUST: bool = true


# Player Model
@onready var character = $PlayerModel
@onready var holdpoint_pivot = $PlayerModel/HoldPointPivot
@onready var holdpoint = $PlayerModel/HoldPointPivot/HoldPoint
@onready var holdpoint_backup = $PlayerModel/HoldPointPivot/Backup
@onready var obstruction_detection = $PlayerModel/ObstructionDetector



# Camera
@onready var pivot = $CentralCameraPoint
@onready var camera = $CentralCameraPoint/SpringArm3D/Camera3D
@onready var ray = $CentralCameraPoint/SpringArm3D/Camera3D/RayCast3D
@onready var ray_endpos = $CentralCameraPoint/SpringArm3D/Camera3D/EndPos


# Cursor
@onready var cursor = $Cursor
@onready var detection = $Cursor/Area3D


# Info
@onready var info = $Info

# HUD
@onready var HUD = $HUD
@onready var pausemenu = $HUD/PauseMenu
@onready var deathscreen = $HUD/DeathScreen
@onready var options_menu = $HUD/OptionsMenu
@onready var hud_levelcomplete = $HUD/LevelCompleted
@onready var hud_levelcomplete_delay = $HUD/LevelCompleted/Delay


# Audio
@onready var footstep_delay = $Audio/FootstepDelay
@onready var sound_footstep = $Audio/PlayerWalk
@onready var sound_select = $Audio/PlayerSelect
@onready var sound_hurt = $Audio/PlayerHurt

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# visuals
@onready var dust = $Dust



var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var faceDirection = Vector3.FORWARD

var oldparent = null

var canPause = true
var levelchangetriggered = false

var tutorial_proximitydrop = false
var main_menu = "res://Elements/function/main_menu.tscn"


# please leave object blank, but keep as export
@export_group("Programming Stuff")
@export var isHolding = false
@export var object : RigidBody3D
@export var level_completed : bool = false
@export var player_hub : String = "res://Elements/environments/misc/player_cell.tscn"
@export var dialogue_queue : Array = [] 

signal DialogueFinished
#endregion



#region Player Gameplay

func _ready():
	
	Engine.time_scale = 1
	canPause = true
	pausemenu.visible = false
	deathscreen.visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	ApplySettings()
	
	if SAVE_GAME:
		var save_system = SaveGame.new()
		save_system.save_game(get_tree().current_scene.scene_file_path)
		print_rich("[rainbow]Saved Level: ", save_system.load_game().level)
	else:
		print("Saving is turned off for this level")
	

func _input(event):
	if event is InputEventMouseMotion and canPause == true:
		
		
		rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
		
		if !velocity and !isHolding:
			character.rotate_y(deg_to_rad(event.relative.x * SENSITIVITY))
		
		pivot.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(MIN_LOOK), deg_to_rad(MAX_LOOK))
		

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y -= gravity * delta * JUMP_FALLMULTIPLIER
		velocity.y = clamp(velocity.y, -38, 500)
	
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	MousePosition()
	
	
	
	if (Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("backward")):
		faceDirection = Vector3(Input.get_action_strength("right") - Input.get_action_strength("left"), 0 ,Input.get_action_strength("backward") - Input.get_action_strength("forward")).normalized()
	
	
	
	if isHolding:
		character.rotation.y = atan2(ray_endpos.position.x, ray_endpos.position.z)
	elif !isHolding and velocity:
		character.rotation.y = lerp_angle(character.rotation.y, atan2(faceDirection.x, faceDirection.z), delta * TURN_VELOCITY)
	elif !velocity and is_on_floor():
		pass
	
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#if direction:
	#	velocity.x = direction.x * SPEED
	#	velocity.z = direction.z * SPEED
	if direction and !isHolding:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif direction and isHolding:
		velocity.x = direction.x * SPEED / (clamp(object.mass / 4, 4, 5) - 3)
		velocity.z = direction.z * SPEED / (clamp(object.mass / 4, 4, 10) - 3)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	
	
	if !isHolding:
		animation_tree.set("parameters/fall/Blend2/blend_amount", 0.0)
		animation_tree.set("parameters/idle/Blend2/blend_amount", 0.0)
		animation_tree.set("parameters/run/Blend2/blend_amount", 0.0)
		animation_tree.set("parameters/land/Blend2/blend_amount", 0.0)
		
	
	elif isHolding:
		animation_tree.set("parameters/fall/Blend2/blend_amount", 1.0)
		animation_tree.set("parameters/idle/Blend2/blend_amount", 1.0)
		animation_tree.set("parameters/run/Blend2/blend_amount", 1.0)
		animation_tree.set("parameters/land/Blend2/blend_amount", 1.0)
	
	if not is_on_floor():
		state_machine.travel("fall")
		animation_tree.set("parameters/fall/FallDirection/blend_amount", clamp(velocity.y, 0, 1))
		
		
		
	elif velocity and is_on_floor():
		state_machine.travel("run")
		
		
		if footstep_delay.is_stopped() and is_on_floor():
			footstep_delay.start()
			sound_footstep.pitch_scale = randf_range(75, 125) / 100
			sound_footstep.play()
		
	else:
		
		state_machine.travel("idle")
	

func _process(_delta):
	HUD.Dialogue()
	
	holdpoint_pivot.rotation.x = clamp(-pivot.rotation.x, deg_to_rad(-60), deg_to_rad(0))
	
	
	if (NearestObject() and NearestObject() is RigidBody3D and global_position.distance_to(NearestObject().global_position) <= PICKUP_RANGE) and isHolding == false:
		
		if NearestObject().is_in_group("ungrabbable"):
			return
		
		HUD.setCursorPosition(NearestObject().global_position, true)
		
		
		if Input.is_action_just_pressed("click"):
			sound_select.play()
			isHolding = true
			object = NearestObject()
			oldparent = object.get_parent()
			
			object.global_transform = holdpoint.global_transform
			
			object.reparent(holdpoint)
			object.set_freeze_enabled(true)
			object.set_freeze_mode(0)
			object.set_collision_layer_value(1, false)
			object.set_collision_mask_value(1, false)
			
			
			
		else:
			pass
	
	
	if !Input.is_action_pressed("click"): 
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
		
		
			if pivot.rotation.x < -1 and is_on_floor():
				force = Vector3(0, 0, 0)
				
				if tutorial_mode and !tutorial_proximitydrop:
					tutorial_proximitydrop = true
					HUD.sendHintToPlayer("You can drop items gently when the cursor is over yourself")
			
			
			for i in obstruction_detection.get_overlapping_bodies():
				if i is StaticBody3D:
					object.global_position = holdpoint_backup.global_position
			
			
			object.apply_impulse(force * THROW_FORCE)
			
			object = null
	
	
	if level_completed:
		Nextlevel()
	
	
	if self.global_position.y <= -1000:
		info.Damage(9999)
	
	if Input.is_action_just_pressed("escape"):
		PauseMenu(true)
	
	
	
	var tween = get_tree().create_tween()
	tween.tween_property($CentralCameraPoint/Wind, "position", camera.global_position, 0.05)
	tween.tween_property($Audio/CameraWind, "pitch_scale", $CentralCameraPoint/Wind.global_position.distance_to(camera.global_position) + 0.1, 0.3)
	
	
	if DISPLAY_DUST and dust.visible != true:
		dust.visible = true
	elif !DISPLAY_DUST and dust.visible != false:
		dust.visible = false



func MousePosition():
	if  ready and canPause: # This statement looks very dumb but without it it'll sometimes crash. The crashing isn't even consistant either!
		
		if ray.is_colliding() and is_instance_valid(ray.get_collider()):
			var rayHit = ray.get_collider()
			cursor.global_position = ray.get_collision_point()
			
			HUD.setCursorPosition(Vector3(), false)
			HUD.viewEnemyHealth(null, false)
			
			if rayHit.is_in_group("enemy"):
				for i in rayHit.get_children():
					if i.is_in_group("info"):
						if i.DisplayHealthBar == true:
							HUD.viewEnemyHealth(rayHit, true)
				
				
				
				if Input.is_action_pressed("click"):
					cursor.global_position = rayHit.global_position
					HUD.setCursorPosition(rayHit.global_position, true)
					
		
		
		elif !ray.is_colliding():
			cursor.global_position = ray_endpos.global_position


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

#endregion





#region Player UI
func RestartLevel():
	LoadingScreen.next_scene = get_tree().current_scene.scene_file_path
	LoadingScreen.scene_transition()



func QuitToMenu():
	LoadingScreen.next_scene = main_menu
	LoadingScreen.scene_transition()


func FinishDialogue(dialogue: String):
	emit_signal("DialogueFinished", dialogue)


func ApplySettings():
	var new_config = SaveConfig.new()
	var settings = new_config.load_config()
	
	SENSITIVITY = settings.SENSITIVITY
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(settings.VOLUME_MUSIC))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(settings.VOLUME_SFX))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ambience"), linear_to_db(settings.VOLUME_AMBIENCE))
	

func PauseMenu(toggle : bool):
	ApplySettings()
	
	if canPause == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = toggle
		pausemenu.visible = toggle
		
		if toggle == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			DisplayServer.tts_pause()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			DisplayServer.tts_resume()


func DeathScreen():
	canPause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0, 0.2)
	
	deathscreen.visible = true


func Nextlevel():
	if levelchangetriggered == false:
		levelchangetriggered = true
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_tree().paused = true
		
		hud_levelcomplete.visible = true
		hud_levelcomplete_delay.start()


func _on_delay_timeout():
	get_tree().paused = false
	
	for i in self.get_parent().get_children():
		if i.is_in_group("objective_start"):
			var save = SaveGame.new()
			save.save_game(i.nextscene_string)
			
			if get_tree().current_scene.scene_file_path == "res://Elements/environments/misc/intro_cutscene.tscn":
				LoadingScreen.next_scene = save.load_game().level
				LoadingScreen.scene_transition()
			
			else:
				LoadingScreen.next_scene = player_hub
				LoadingScreen.scene_transition()
	
	
	if !SAVE_GAME:
		var save = SaveGame.new()
		
		if save.load_game():
			if save.load_game().level:
				LoadingScreen.next_scene = save.load_game().level
				LoadingScreen.scene_transition()
		else:
			push_error("Failed to find next level.")
	
	



func _on_resume_button_pressed():
	PauseMenu(false)

func _on_restart_button_pressed():
	RestartLevel()

func _on_death_restart_button_pressed():
	RestartLevel()

func _on_quit_button_pressed():
	QuitToMenu()

func _on_death_quit_button_pressed():
	QuitToMenu()

func _on_options_button_pressed():
	options_menu.visible = true

#endregion



#region Player Misc

func SendHintToPlayer(hint: String):
	HUD.sendHintToPlayer(hint)

func _on_info_take_damage():
	sound_hurt.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	sound_hurt.play(0)
	
	$PlayerModel/player/AnimationPlayer.play("pain")

func _on_info_death():
	$Audio/PlayerDeath.pitch_scale = randf_range(75, 125) / 100 # random value between 0.75 and 1.25
	$Audio/PlayerDeath.play()
	
	canPause = false
	
	if SAVE_GAME:
		var save = SaveGame.new()
		save.save_game(get_tree().current_scene.scene_file_path)
	
	LoadingScreen.next_scene = player_hub
	LoadingScreen.scene_transition()

#endregion




# <-- This number is the amount of times I have lost the will to live
