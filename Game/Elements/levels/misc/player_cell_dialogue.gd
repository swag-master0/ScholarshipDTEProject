extends Node


@export var dialogue_delay : float = 3

@onready var player = $"../Player"
@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
@onready var player_hub = $".."



var allow_exit = false

var PathL1 = "res://Elements/levels/main_levels/L1.tscn"
var PathL2 = "res://Elements/levels/main_levels/L2.tscn"
var PathL3 = "res://Elements/levels/main_levels/L3.tscn"
var PathL4 = "res://Elements/levels/main_levels/L4.tscn"
var PathL5 = "res://Elements/levels/main_levels/L5.tscn"
var PathL6 = "res://Elements/levels/main_levels/L6.tscn"
var PathL7 = "res://Elements/levels/main_levels/L7.tscn"
var PathL8 = "res://Elements/levels/main_levels/L8.tscn"
var PathL9 = "res://Elements/levels/main_levels/L9.tscn"
var PathL10 = "res://Elements/levels/main_levels/L10.tscn"


func _on_exit_body_entered(body):
	if body.is_in_group("player") and allow_exit == true:
		rail_anims.play("up")


func _on_player_hub_object_burnt(body):
	if body.is_in_group("objective"):
		
		BurnedObjective()
		player_hub.ActivateIncinerator(false)


# Everything below this point is a hellish hellscape
# To make this coherant and logical, I could maybe NOT do this terrible-ness
# Hopefully I can pretend this script doesn't exist when documenting

func _ready():
	rail_anims.play("down")
	
	var save = SaveGame.new()
	print(save.load_game().level)
	
	# I don't even know
	if save.load_game() == null:
		rail_anims.play("down") # why? This shouldn't even happen, so why am I calling this animation???
	
	else:
		await get_tree().create_timer(dialogue_delay).timeout
		
		if save.load_game().level == PathL1:
			player.dialogue_queue.append_array(L1_IntroDialogue)
		
		elif save.load_game().level == PathL2:
			player.dialogue_queue.append_array(L2_IntroDialogue)
		
		elif save.load_game().level == PathL3:
			player.dialogue_queue.append_array(L3_IntroDialogue)
		
		elif save.load_game().level == PathL4:
			player.dialogue_queue.append_array(L4_IntroDialogue)
		
		elif save.load_game().level == PathL5:
			player.dialogue_queue.append_array(L5_IntroDialogue)
		
		elif save.load_game().level == PathL6:
			player.dialogue_queue.append_array(L6_IntroDialogue)
		
		elif save.load_game().level == PathL7:
			player.dialogue_queue.append_array(L7_IntroDialogue)
		
		elif save.load_game().level == PathL8:
			player.dialogue_queue.append_array(L8_IntroDialogue)
		
		elif save.load_game().level == PathL9:
			player.dialogue_queue.append_array(L9_IntroDialogue)
		
		elif save.load_game().level == PathL10:
			player.dialogue_queue.append_array(L10_IntroDialogue)
		

func BurnedObjective():
	var save = SaveGame.new()
	await get_tree().create_timer(dialogue_delay).timeout
	
	if save.load_game().level == PathL2:
		player.dialogue_queue.append_array(L2_IntroDialogue_2)
	
	elif save.load_game().level == PathL3:
		player.dialogue_queue.append_array(L3_IntroDialogue_2)
	
	elif save.load_game().level == PathL4:
		player.dialogue_queue.append_array(L4_IntroDialogue_2)
	
	elif save.load_game().level == PathL5:
		player.dialogue_queue.append_array(L5_IntroDialogue_2)
	
	elif save.load_game().level == PathL6:
		player.dialogue_queue.append_array(L6_IntroDialogue_2)
	
	elif save.load_game().level == PathL7:
		player.dialogue_queue.append_array(L7_IntroDialogue_2)
	
	elif save.load_game().level == PathL8:
		player.dialogue_queue.append_array(L8_IntroDialogue_2)
	
	elif save.load_game().level == PathL9:
		player.dialogue_queue.append_array(L9_IntroDialogue_2)
	
	elif save.load_game().level == PathL10:
		player.dialogue_queue.append_array(L10_IntroDialogue_2)
	

func _on_player_dialogue_finished(dialogue: String):
	# I'm so sorry
	
	if dialogue == L2_IntroDialogue.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L3_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L4_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L5_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L6_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L7_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L8_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L9_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	elif dialogue == L10_IntroDialogue_2.back():
		player_hub.ActivateIncinerator(true)
	
	if dialogue == L1_IntroDialogue.back():
		allow_exit = true
	elif dialogue == L2_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L3_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L4_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L5_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L6_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L7_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L8_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L9_IntroDialogue_2.back():
		allow_exit = true
	elif dialogue == L10_IntroDialogue_2.back():
		allow_exit = true
	

# The written dialogue is found here
# Yes, I have variables at the bottom of my script, instead of the top
# I did not want these sitting on top, so I'd have to scroll past these every single time I have to change this script
#region Dialogue Hell

var L1_IntroDialogue = [
	# This shouldn't trigger, but is here anyway to prevent major bugs
	1,
	"i don't think something's right",
	7,
	"what did you do?",
	"how did you get here"
]
var L1_IntroDialogue_2 = [
	1,
	"go! start the game",
	"you shouldn't be here anyways"
]


var L2_IntroDialogue = [
	5,
	"sweet!",
	8,
	"now, the final step...",
	5,
	"please place the egg inside the [i][color=YELLOW_GREEN][wave]handy-dandy furnace!" ]
	#[wave amp=50.0 freq=5.0 connected=1]
var L2_IntroDialogue_2 = [
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


var L3_IntroDialogue = [
	0, 
	"...",
	8, 
	"just burn it. "
]
var L3_IntroDialogue_2 = [
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

var L4_IntroDialogue = [
	1,
	"hey, that went reasonable well. [wave]nice fighting",
	5,
	"opening the furnace!"
]
var L4_IntroDialogue_2 = [
	5,
	"you're getting the hang of this",
	1,
	"this next one should be a piece of cake for you!"
]

var L5_IntroDialogue = [
	0,
	"...",
	2,
	"burn that again please... "
]
var L5_IntroDialogue_2 = [
	0,
	"...",
	2,
	"they're getting smarter... [i]that's not supposed to happen",
	"i thought they were incapable of evolving, since i made them that way",
	str("i make them just like you, ", PlayerName.new().fetch_name(), "."),
	1,
	"back to the lift. "
]


var L6_IntroDialogue = [
	0,
	"...",
	1,
	"burn it"
]
var L6_IntroDialogue_2 = [
	0,
	"...",
	1,
	"epic"
]

var L7_IntroDialogue = [
	0,
	"...",
	1,
	"i n c i n e r a t e"
]
var L7_IntroDialogue_2 = [
	0,
	"...",
	1,
	"splendid.",
	"on the elevator-"
]

var L8_IntroDialogue = [
	0,
	"...",
	1,
	"burn the child"
]
var L8_IntroDialogue_2 = [
	0,
	"...",
	1,
	"epic.."
]

var L9_IntroDialogue = [
	0,
	"...",
]
var L9_IntroDialogue_2 = [
	0,
	"...",
	1,
	"epic..."
]

var L10_IntroDialogue = [
	0,
	"...",
	1,
	"remove it"
]
var L10_IntroDialogue_2 = [
	0,
	"...",
	1,
	"epic...."
]
#endregion

# <-- AAAAAAAAAAAAAAAAAAAAAAA
