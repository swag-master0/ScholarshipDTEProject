extends Node3D

@export var ending_dialogue1 : String = "It's come to this."
@export var ending_dialogue2 : String = "Their actions led us here,"
@export var ending_dialogue3 : String = "Their unwillingness to change."
@export var ending_dialogue4 : String = "Their choice led us here,"
@export var ending_dialogue5 : String = "To the end of the road."

@onready var player = $Player
@onready var black = $Black
@onready var particles = $Particles

@onready var text = $TextLayer/Text
@onready var timer = $TextLayer/Timer

@onready var name_label = $YourGraveLabel


var scene_transition_triggered = false

func _ready():
	name_label.text = PlayerName.new().fetch_name()
	text.text = ""
	
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	await get_tree().create_timer(10).timeout
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(1).timeout
	black.visible = false
	$DistortedMusic.play()
	$LightTurnOn.play()

func _process(_delta):
	particles.global_position = player.global_position + Vector3(-25, 0, 0)
	
	if player.global_position.y > 60:
		black.visible = true
		
		if scene_transition_triggered == false:
			scene_transition_triggered = true
			$DistortedMusic.stop()
			$EndingStinger.stop()
			
			await get_tree().create_timer(8).timeout
			LoadingScreen.next_scene = "res://Elements/function/credits.tscn"
			LoadingScreen.scene_transition()
		



func _on_trigger_1_body_entered(body):
	if body.is_in_group("player"):
		text.text = "[center][wave]" + ending_dialogue1
		timer.start()


func _on_trigger_2_body_entered(body):
	if body.is_in_group("player"):
		text.text = "[center][wave]" + ending_dialogue2
		timer.start()


func _on_trigger_3_body_entered(body):
	if body.is_in_group("player"):
		text.text = "[center][wave]" + ending_dialogue3
		timer.start()


func _on_trigger_4_body_entered(body):
	if body.is_in_group("player"):
		text.text = "[center][wave]" + ending_dialogue4
		timer.start()


func _on_trigger_5_body_entered(body):
	if body.is_in_group("player"):
		text.text = "[center][wave]" + ending_dialogue5
		timer.start()
		
		await get_tree().create_timer(4).timeout
		
		player.GRAVITY = -0.3
		$EndingStinger.play()


func _on_timer_timeout():
	text.text = ""
