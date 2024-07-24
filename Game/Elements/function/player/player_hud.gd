extends Control

@onready var parent = $".."
@onready var info = $"../Info"

@onready var hud_health = $Health
@onready var hud_healthwhite = $Health/HealthWhite

@onready var hinttext = $Hints
@onready var hinttimer = $Hints/Timer

var health = info.health
var max_health = info.max_health

var tutorial_pickup = false


var healthvisualindicator = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
		

