extends Node3D

@onready var player: CharacterBody3D = $Player


# TODO: add dialogue in this level;
# player.dialogue_queue.append("try climbing on something to get up")

func _ready():
	await get_tree().create_timer(5).timeout
	
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("i've noticed a lot of those creatures here, but i need that egg gone!")
	player.dialogue_queue.append(7)
	player.dialogue_queue.append("although, i'm interested in how you fight")
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("remember! [color=GOLD]cretins can easily be [i]deterred[/i] through blunt force trauma to the head")
