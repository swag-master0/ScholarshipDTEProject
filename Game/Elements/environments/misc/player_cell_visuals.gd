extends Node

# This script is gonna be hell to work with
# Heaps of treadmill work and copy/pasting similar statements. Oh well, I struggle to see a better way to do this


@onready var player = $"../Player"
@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"

var c1_m1_IntroDialogue = [
	0,
	"i don't think something's right",
	"what did you do?"
]

var c1_m2_IntroDialogue = [
	0,
	"sweet!",
	"i just realised i never gave you a mouth, so you have no feasable way to eat that",
	"oh well",
	1,
	"...",
	0,
	"i'm bored",
	"you wanna do that again?",
	"i'll send the lift down.."
]

var c1_m3_IntroDialogue = [
	"i dunno" #TODO
]



var allow_exit = false

var c1_m1Path = "res://Elements/environments/chapter1/c1_m1.tscn"
var c1_m2Path = "res://Elements/environments/chapter1/c1_m2.tscn"
var c1_m3Path = "res://Elements/environments/chapter1/c1_m3.tscn"


# TODO: create a way for the rail anims to trigger

func _ready():
	rail_anims.play("down")
	
	var save = SaveGame.new()
	
	if save.load_game() == null:
		rail_anims.play("down")
	else:
		if save.load_game().level == c1_m1Path:
			# Under no circumstance should this trigger.
			# There should be no feasable way for the player to be in the normal player cell with the save set to c1_m1.
			# If this occurs, something went TERRIBLY wrong. This is only here to prevent errors and to keep things consistent
			player.dialogue_queue.append_array(c1_m1_IntroDialogue)
		
		elif save.load_game().level == c1_m2Path:
			player.dialogue_queue.append_array(c1_m2_IntroDialogue)
		elif save.load_game().level == c1_m3Path:
			player.dialogue_queue.append_array(c1_m3_IntroDialogue)
		
	



func _process(_delta):
	await get_tree().create_timer(10).timeout
	allow_exit = true
	


func _on_player_dialogue_finished(dialogue):
	if dialogue == c1_m1_IntroDialogue.back():
		allow_exit = true
	elif dialogue == c1_m2_IntroDialogue.back():
		allow_exit = true
	elif dialogue == c1_m3_IntroDialogue.back():
		allow_exit = true
	


func _on_exit_body_entered(body):
	if body.is_in_group("player") and allow_exit == true:
		rail_anims.play("up")

