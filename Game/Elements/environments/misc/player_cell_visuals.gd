extends Node

# This script is gonna be hell to work with
# Heaps of treadmill work and copy/pasting similar statements. Oh well, I struggle to see a better way to do this


@onready var player = $"../Player"
@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
@onready var player_hub = $".."

var furnaceActivated : bool = false
var furnaceActivationKeywords = ["furnace", "toaster", "oven"]


var c1_m1_IntroDialogue = [
	# This shouldn't trigger, but is here anyway to prevent major bugs
	0,
	"i don't think something's right",
	"what did you do?",
	"how did you get here"
]


var c1_m2_IntroDialogue = [
	0,
	"sweet!",
	"now, the final step...",
	"please place the egg inside the [i][color=HONEYDEW][wave]handy-dandy furnace!" ]
	#[wave amp=50.0 freq=5.0 connected=1]
var c1_m2_IntroDialogue_2 = [
	1,
	"...",
	0,
	"thanks heaps",
	"now to do that about...",
	1, 
	"approximately 9,471 more times.",
	1,
	"get back on the lift.. ya got work to do"
]


var c1_m3_IntroDialogue = [
	"i dunno" #TODO
]

var c1_m4_IntroDialogue = [
	"i dunno" #TODO
]


var allow_exit = false

var c1_m1Path = "res://Elements/environments/chapter1/c1_m1.tscn"
var c1_m2Path = "res://Elements/environments/chapter1/c1_m2.tscn"
var c1_m3Path = "res://Elements/environments/chapter1/c1_m3.tscn"
var c1_m4Path = "res://Elements/environments/chapter1/c1_m4.tscn"


func _ready():
	rail_anims.play("down")
	
	var save = SaveGame.new()
	
	if save.load_game() == null:
		rail_anims.play("down")
	else:
		if save.load_game().level == c1_m1Path:
			await get_tree().create_timer(3).timeout
			player.dialogue_queue.append_array(c1_m1_IntroDialogue)
		elif save.load_game().level == c1_m2Path:
			await get_tree().create_timer(3).timeout
			player.dialogue_queue.append_array(c1_m2_IntroDialogue)
		elif save.load_game().level == c1_m3Path:
			await get_tree().create_timer(3).timeout
			player.dialogue_queue.append_array(c1_m3_IntroDialogue)
		elif save.load_game().level == c1_m4Path:
			await get_tree().create_timer(3).timeout
			player.dialogue_queue.append_array(c1_m4_IntroDialogue)
		

func BurnedObjective():
	var save = SaveGame.new()
	
	if save.load_game().level == c1_m2Path:
		await get_tree().create_timer(3).timeout
		player.dialogue_queue.append_array(c1_m2_IntroDialogue_2)

func _on_player_dialogue_finished(dialogue: String):
	if dialogue == c1_m1_IntroDialogue.back():
		allow_exit = true
	elif dialogue == c1_m2_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == c1_m3_IntroDialogue.back():
		allow_exit = true
	elif dialogue == c1_m4_IntroDialogue.back():
		allow_exit = true
	
	for i in furnaceActivationKeywords:
		if dialogue.contains(i) and !furnaceActivated:
			furnaceActivated = true
			player_hub.ActivateIncinerator(true)
	


func _on_exit_body_entered(body):
	if body.is_in_group("player") and allow_exit == true:
		rail_anims.play("up")


func _on_player_hub_object_burnt(body):
	if body.is_in_group("objective"):
		print("burned objective")
		BurnedObjective()
		player_hub.ActivateIncinerator(false)
	print(body)
