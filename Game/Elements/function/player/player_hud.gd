extends Control

@onready var parent = $".."
@onready var info = $"../Info"
@onready var camera = $"../CentralCameraPoint/SpringArm3D/Camera3D"
@onready var tutorial_mode = parent.tutorial_mode

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

var skipBBCode = false



func _ready():
	hud_dialogue_box.visible = false
	hurt_vfx.visible = false
	


func _process(_delta):
	if get_tree().current_scene.scene_file_path == "res://Elements/environments/misc/intro_cutscene.tscn":
		a_os_name.visible = false
	
	if ready: 
		var currenthealth = info.health
		
		hud_health.value = currenthealth
		hud_health.max_value = max_health
		#hud_healthwhite.max_value = max_health
		
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
func Dialogue(text_speed : float = 0.025, time_until_continue : float = 1.5):
	
	if dialoguespeaking == false and !dialogue_queue.is_empty():
		dialoguespeaking = true
		
		hud_dialogue_box.visible = true
		
		for i in dialogue_queue:
			var dialogue = dialogue_queue.pop_front()
			
			if dialogue is int:
				A_OS.ApplyMood(dialogue)
				continue
			
			elif dialogue is String:
				hud_dialogue.visible = true
				hud_dialogue.text = dialogue
				hud_dialoguedelay.wait_time = text_speed
				
				# I was gonna have some over-complicated mechanism here that filtered the RichTextLabel's BBCode to format correctly
				# But turns out Godot just automatically does it lmao
				# I have to do this or else it includes each bb code character when emitting the audio and effects, meaning it sounds like there's more letters than there actually are
				var formatted_string = hud_dialogue.get_parsed_text()
				
				for x in formatted_string.length():
					hud_dialoguedelay.wait_time = text_speed
					hud_dialogue.visible_characters = x + 1
					
					sound_dialogue.pitch_scale = randf_range(50, 150) / 100
					sound_dialogue.play()
					A_OS.Yap()
					
					if formatted_string[x] == "-":
						hud_dialoguedelay.wait_time = 0
					elif formatted_string[x] == "." or formatted_string[x] == "," or formatted_string[x] == "{" or formatted_string[x] == "}":
						hud_dialoguedelay.wait_time += 0.25
					
					hud_dialoguedelay.start()
					await hud_dialoguedelay.timeout
			
			parent.FinishDialogue(dialogue)
			if dialogue is String:
				if dialogue.ends_with("-"):
					continue
				else:
					await get_tree().create_timer(text_speed * dialogue.length() + time_until_continue).timeout
		
		dialoguespeaking = false
		hud_dialogue_box.visible = false
		

func _on_remove_characters_timeout():
	hud_dialogue.visible = false
	hud_dialogue.text = ""

func PainVisuals():
	hurt_vfx.visible = true
	pain_animation.play("pain")

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
		
