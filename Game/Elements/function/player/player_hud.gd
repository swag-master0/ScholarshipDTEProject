extends Control

@onready var parent = $".."
@onready var info = $"../Info"
@onready var camera = $"../CentralCameraPoint/SpringArm3D/Camera3D"

@onready var hud_health = $Health
@onready var hud_healthwhite = $Health/HealthWhite

@onready var hinttext = $Hints
@onready var hinttimer = $Hints/Timer

@onready var dialogue_queue = parent.dialogue_queue
@onready var hud_dialogue_box = $DialogueBox
@onready var hud_dialogue = $DialogueBox/DialogueText
@onready var hud_dialoguedelay = $DialogueBox/DelayBetweenCharacters
@onready var hud_dialogueremove = $DialogueBox/RemoveCharacters
@onready var hud_AOSvisual = $"DialogueBox/A-OS Visual"
@onready var sound_dialogue = $"../Audio/Dialogue"
@onready var continue_prompt = $DialogueBox/ContinuePrompt


@onready var indicator = $Indicator
@onready var indicator_tutorial = $Indicator/AnimatedSprite2D

@onready var A_OS = $"../A-OS Viewport/A-OS"
@onready var a_os_name = $DialogueBox/Name


@onready var hurt_vfx = $HurtVFX
@onready var pain_animation = $HurtVFX/AnimationPlayer


@onready var health = info.health
@onready var max_health = info.max_health

var dialoguespeaking = false
var tutorial_pickup = false
var healthvisualindicator = false
var selectionsound = false

var skip_dialogue = false

signal NextDialogue

signal SkipDialogue

func _ready():
	hud_dialogue_box.visible = false
	hurt_vfx.visible = false


func _process(_delta):
	if get_tree().current_scene.scene_file_path == "res://Elements/environments/misc/intro_cutscene.tscn":
		a_os_name.visible = false
	

	if Input.is_action_just_pressed("dialogue_skip"):
		SkipDialogue.emit()
	
	
	if ready: 
		var currenthealth = info.health
		
		hud_health.value = currenthealth
		hud_health.max_value = max_health
		
		
		if currenthealth == max_health:
			hud_health.visible = false
		else:
			hud_health.visible = true
		
		
		if hud_healthwhite.value != hud_health.value and !healthvisualindicator:
			healthvisualindicator = true
			
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(hud_healthwhite, "value", currenthealth, 1)
			
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
func Dialogue(text_speed : float = 0.02):
	
	if dialoguespeaking == false and !dialogue_queue.is_empty():
		dialoguespeaking = true
		
		hud_dialogue_box.visible = true
		
		for i in dialogue_queue:
			continue_prompt.visible = false
			
			var dialogue = dialogue_queue.pop_front()
			skip_dialogue = false
			
			if dialogue is int:
				A_OS.ApplyMood(dialogue)
				continue
			
			elif dialogue is String:
				hud_dialogue.visible = true
				hud_dialogue.text = dialogue
				hud_dialoguedelay.wait_time = text_speed
				
				var formatted_string = hud_dialogue.get_parsed_text()
				
				for x in formatted_string.length():
					hud_dialoguedelay.wait_time = text_speed
					hud_dialogue.visible_characters = x + 1
					
					sound_dialogue.pitch_scale = randf_range(50, 150) / 100
					sound_dialogue.play()
					A_OS.Yap()
					
					# Delay dialogue on certain characters for added effect
					if formatted_string[x] == "-":
						hud_dialoguedelay.wait_time = 0.01
					elif formatted_string[x] == "." or formatted_string[x] == "," or formatted_string[x] == "{" or formatted_string[x] == "}":
						hud_dialoguedelay.wait_time += 0.125
					
					
					hud_dialoguedelay.start()
					await hud_dialoguedelay.timeout
			
			
			parent.FinishDialogue(dialogue)
			
			if dialogue is String:
				if dialogue.ends_with("-"):
					continue
				else:
					continue_prompt.visible = true
					await SkipDialogue
					continue_prompt.visible = false
					NextDialogue.emit()
		
		dialoguespeaking = false
		hud_dialogue_box.visible = false
		


func PainVisuals():
	hurt_vfx.visible = true
	pain_animation.play("pain")

# INFO: LOCK-ON CURSOR AND ENEMY HEALTH BARS
func setCursorPosition(pos : Vector3, visibility : bool):
	if visibility:
		indicator.visible = true
		indicator.position = camera.unproject_position(pos) - indicator.size / 2
	
	elif !visibility:
		indicator.visible = false
		selectionsound = false
		
