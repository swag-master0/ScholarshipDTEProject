extends Node3D

@onready var player = $Player
@onready var stinger = $Stinger


func _ready():
	await get_tree().create_timer(3).timeout
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("i know what it looks like, but bare with me for a sec")
	player.dialogue_queue.append(8)
	player.dialogue_queue.append("i've had to leave it here because i'm scared of it...")
	player.dialogue_queue.append(2)
	player.dialogue_queue.append("i don't know if it's armed, and i fear it could be the end of us")
	


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "up":
		stinger.play()


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		pass
		# dialogue here
