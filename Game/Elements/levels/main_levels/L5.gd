extends Node3D

@onready var player = $Player

func _ready():
	await get_tree().create_timer(1).timeout
	player.dialogue_queue.append("you're gonna like this-")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "up":
		player.dialogue_queue.append("surprise :)")
		player.dialogue_queue.append("")
