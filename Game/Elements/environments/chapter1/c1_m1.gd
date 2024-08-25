extends Node3D

var playerHasObjective = false
var DecorDialogue : bool = false

@onready var player = $Player


func _ready():
	await get_tree().create_timer(2).timeout
	
	player.dialogue_queue.append(5)
	player.dialogue_queue.append("welcome to the surface world!")
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("it's a lil' messed up, but that's probably fine.")
	player.dialogue_queue.append("anyways, we're here. there should be a nest up ahead")


func _process(_delta):
	for i in self.get_children():
		if i.is_in_group("player"):
			if is_instance_valid(i.object) and i.object.is_in_group("objective") and !playerHasObjective:
				playerHasObjective = true
				
				await get_tree().create_timer(2).timeout
				
				player.dialogue_queue.append(1)
				player.dialogue_queue.append("now, my favor for you, please bring that back here")
				player.dialogue_queue.append(4)
				player.dialogue_queue.append("the lift is waiting for you.")
				
				#i.Dialogue("Good. Now get that thing back here.")


func _on_tutorial_trigger_body_entered(body):
	if body.is_in_group("player") and playerHasObjective and !DecorDialogue:
		DecorDialogue = true
		
		player.dialogue_queue.append(1)
		player.dialogue_queue.append("hey, by the way. if you want to keep anything around here")
		player.dialogue_queue.append(4)
		player.dialogue_queue.append("feel free to bring it back with you. the lift [font_size=5]should[/font_size] support it")
		player.dialogue_queue.append(5)
		player.dialogue_queue.append("i'd like to see how you'd decorate that box I gave you ")
