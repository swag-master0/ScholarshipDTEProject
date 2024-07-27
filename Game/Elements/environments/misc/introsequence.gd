extends Node

@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
@onready var lights = [
	$"../Light",
	$"../Light2"
]

@onready var player = $"../Player"




func _ready():
	
	for i in lights:
		i.light_energy = 0
	
	
	await get_tree().create_timer(3).timeout
	
	for i in lights:
		i.light_energy = 1.5
	
	await get_tree().create_timer(3).timeout
	
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("PLEASE COMPLETE THE FOLLOWING DIAGNOSTIC COURSE. ")
	player.dialogue_queue.append("FAILURE TO DO SO MAY LEAD TO UNEXPECTED SIDE EFFECTS, SUCH AS: 

DEATH")
	player.dialogue_queue.append("DIAGNOSTIC COURSE IS NOW BEGINNING. ")
	movement_tutorial()
	


func movement_tutorial():
	player.dialogue_queue.append("...")
	player.dialogue_queue.append("...")
	player.dialogue_queue.append("PLEASE DEMONSTRATE BASIC MOVEMENT CAPABILITIES. ")
	
	
	




func _on_player_dialogue_finished(dialogue):
	if dialogue == "DIAGNOSTIC COURSE IS NOW BEGINNING. ":
		movement_tutorial()
	elif dialogue == "PLEASE DEMONSTRATE BASIC MOVEMENT CAPABILITIES. ":
		player.SendHintToPlayer("Use WASD to move")
	
	
	
	



func _on_crushed_body_entered(body):
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(99999)




