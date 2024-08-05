extends Node

@onready var player = $"../Player"

var c1_m1_IntroDialogue = [
	"how the fuck?"
]

var c1_m2_IntroDialogue = [
	"cunt"
]

var c1_m3_IntroDialogue = [
	"bitchass"
]


@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
var allow_exit = false

var c1_m1Path = "res://Elements/environments/chapter1/c1_m1.tscn"
var c1_m2Path = "res://Elements/environments/chapter1/c1_m2.tscn"
var c1_m3Path = "res://Elements/environments/chapter1/c1_m3.tscn"




func _ready():
	rail_anims.play("down")
	
	var save = SaveGame.new()
	
	if save.load_game() == null:
		rail_anims.play("down")
	else:
		if save.load_game().level == c1_m1Path:
			# Under no circumstance should this trigger.
			# There should be no feasable way for the player to be in the normal player cell with the save set to c1_m1.
			# If this occurs, something went TERRIBLY wrong
			player.dialogue_queue.append_array(c1_m1_IntroDialogue)
		
		elif save.load_game().level == c1_m2Path:
			player.dialogue_queue.append_array(c1_m2_IntroDialogue)
		elif save.load_game().level == c1_m3Path:
			player.dialogue_queue.append_array(c1_m3_IntroDialogue)
		
	



func _process(_delta):
	await get_tree().create_timer(10).timeout
	allow_exit = true
	


func _on_exit_body_entered(body):
	if body.is_in_group("player") and allow_exit == true:
		rail_anims.play("up")


func _on_player_dialogue_finished(dialogue):
	print(dialogue)
	pass # Replace with function body.
