extends Control

@onready var parent = $".."
@onready var info = $"../Info"
@onready var camera = $"../CentralCameraPoint/SpringArm3D/Camera3D"
@onready var tutorial_mode = parent.tutorial_mode

@onready var hud_health = $Health
@onready var hud_healthwhite = $Health/HealthWhite
@onready var hud_enemyhealth = $EnemyHealth

@onready var hinttext = $Hints
@onready var hinttimer = $Hints/Timer

@onready var dialogue_queue = parent.dialogue_queue
@onready var hud_dialogue = $Dialogue
@onready var hud_dialoguedelay = $Dialogue/DelayBetweenCharacters
@onready var hud_dialogueremove = $Dialogue/RemoveCharacters
@onready var sound_dialogue = $"../Audio/Dialogue"

@onready var indicator = $Indicator
@onready var indicator_tutorial = $Indicator/AnimatedSprite2D

@onready var crosshair = $Crosshair





@onready var health = info.health
@onready var max_health = info.max_health

var dialoguespeaking = false
var tutorial_pickup = false
var healthvisualindicator = false
var selectionsound = false
var current_crosshair = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if parent.isHolding and current_crosshair != 3:
		changeCrosshair(1)
	
	
	if ready: 
		var health = info.health
		
		hud_health.value = health
		hud_health.max_value = max_health
		hud_healthwhite.max_value = max_health
		
		if health == max_health:
			hud_health.visible = false
		else:
			hud_health.visible = true
		
		
		
		if hud_healthwhite.value != hud_health.value and !healthvisualindicator:
			healthvisualindicator = true
			
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(hud_healthwhite, "value", health, 1)
			
			await tween.finished
			hud_healthwhite.value = hud_health.value
			
			healthvisualindicator = false




func sendHintToPlayer(hint):
	hinttext.text = hint
	hinttimer.start()

func _hinttext_timeout():
	hinttext.text = ""
	
	if tutorial_pickup:
		tutorial_pickup = false
		
		



# INFO: DIALOGUE SYSTEM
func Dialogue(text_speed : float = 0.05, time_until_continue : float = 4):
	
	
	if dialoguespeaking == false and !dialogue_queue.is_empty():
		dialoguespeaking = true
		
		for i in dialogue_queue:
			var dialogue : String = i
			dialogue_queue.erase(i)
			
			hud_dialogue.visible = true
			hud_dialogue.text = dialogue
			hud_dialoguedelay.wait_time = text_speed
			
			for x in dialogue.length():
				hud_dialogue.visible_characters = x + 1
				
				sound_dialogue.pitch_scale = randf_range(50, 150) / 100
				sound_dialogue.play()
				
				hud_dialoguedelay.start()
				await hud_dialoguedelay.timeout
		
		
		
		await get_tree().create_timer(time_until_continue).timeout
		dialoguespeaking = false
		hud_dialogue.visible = false
		

func _on_remove_characters_timeout():
	hud_dialogue.visible = false
	hud_dialogue.text = ""


# INFO: LOCK-ON CURSOR AND ENEMY HEALTH BARS
func setCursorPosition(pos : Vector3, visibility : bool):
	
	if visibility:
		
		indicator.visible = true
		indicator.position = camera.unproject_position(pos) - indicator.size / 2
		changeCrosshair(2)
		
		
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
		
		changeCrosshair(0)
		


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



func changeCrosshair(type : int):
	crosshair.texture.current_frame = type
	current_crosshair = type
	








