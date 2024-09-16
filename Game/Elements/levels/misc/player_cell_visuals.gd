extends Node

# This script is gonna be hell to work with
# Heaps of treadmill work and copy/pasting similar statements. Oh well, I struggle to see a better way to do this


@onready var player = $"../Player"
@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
@onready var player_hub = $".."

var furnaceActivated : bool = false
var furnaceActivationKeywords = ["furnace", "toaster", "oven", "burn"]

#region Dialogue Hell

var c1_m1_IntroDialogue = [
	# This shouldn't trigger, but is here anyway to prevent major bugs
	1,
	"i don't think something's right",
	7,
	"what did you do?",
	"how did you get here"
]


var c1_m2_IntroDialogue = [
	5,
	"sweet!",
	8,
	"now, the final step...",
	5,
	"please place the egg inside the [i][color=YELLOW_GREEN][wave]handy-dandy furnace!" ]
	#[wave amp=50.0 freq=5.0 connected=1]
var c1_m2_IntroDialogue_2 = [
	0,
	"...",
	5,
	"thanks heaps",
	1,
	"now to do that about...",
	0, 
	"approximately 9,471 more times.",
	6,
	str("get back on the lift, ", PlayerName.new().fetch_name(), ".", "... ya got work to do")
]


var c1_m3_IntroDialogue = [
	0, 
	"...",
	8, 
	"just burn it. "
]
var c1_m3_IntroDialogue_2 = [
	0, 
	"...",
	2,
	"i didn't expect company for that one.",
	8,
	"i guess [b]i'm sorry[/b], i should have seen that coming",
	"...",
	2,
	"these eggs you're getting for me, we're taking their eggs",
	"they're parasites, we're doing the world a favor, what's left of it anyway",
	1,
	"get back on the lift, we still have work to do."
]

var c1_m4_IntroDialogue = [
	1,
	"hey, that went reasonable well. [wave]nice fighting",
	5,
	"opening the furnace!"
]
var c1_m4_IntroDialogue_2 = [
	5,
	"you're getting the hang of this",
	1,
	"this next one should be a piece of cake for you!"
]

var endPath_IntroDialogue = [
	0,
	"...",
	2,
	"burn that again please... "
]
var endPath_IntroDialogue_2 = [
	0,
	"...",
	2,
	"they're getting smarter... [i]that's not supposed to happen",
	"i thought they were incapable of evolving, since i made them that way",
	str("i make them just like you, ", PlayerName.new().fetch_name(), "."),
	1,
	"back to the lift. "
]
#endregion


var allow_exit = false

var c1_m1Path = "res://Elements/levels/chapter1/c1_m1.tscn"
var c1_m2Path = "res://Elements/levels/chapter1/c1_m2.tscn"
var c1_m3Path = "res://Elements/levels/chapter1/c1_m3.tscn"
var c1_m4Path = "res://Elements/levels/chapter1/c1_m4.tscn"
var endPath = "res://Elements/function/demo_complete_screen.tscn"


func _ready():
	rail_anims.play("down")
	
	var save = SaveGame.new()
	
	print(save.load_game().level)
	
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
		elif save.load_game().level == endPath:
			await get_tree().create_timer(3).timeout
			player.dialogue_queue.append_array(endPath_IntroDialogue)

func BurnedObjective():
	var save = SaveGame.new()
	
	if save.load_game().level == c1_m2Path:
		await get_tree().create_timer(3).timeout
		player.dialogue_queue.append_array(c1_m2_IntroDialogue_2)
	elif save.load_game().level == c1_m3Path:
		await get_tree().create_timer(3).timeout
		player.dialogue_queue.append_array(c1_m3_IntroDialogue_2)
	elif save.load_game().level == c1_m4Path:
		await get_tree().create_timer(3).timeout
		player.dialogue_queue.append_array(c1_m4_IntroDialogue_2)
	elif save.load_game().level == endPath:
		await get_tree().create_timer(3).timeout
		player.dialogue_queue.append_array(endPath_IntroDialogue_2)

func _on_player_dialogue_finished(dialogue: String):
	if dialogue == c1_m1_IntroDialogue.back():
		allow_exit = true
	elif dialogue == c1_m2_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == c1_m3_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == c1_m4_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == endPath_IntroDialogue_2.back():
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
		
		BurnedObjective()
		player_hub.ActivateIncinerator(false)
