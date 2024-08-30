extends Node

@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
@onready var rail_carriage = $"../RailsPlayerHub/carraige"

@onready var lights = [
	$"../Light",
	$"../Light2"
]
@onready var root = $".."
@onready var player = $"../Player"

@export var object: PackedScene

var activate_movement_tutorial = false
var activate_jumping_tutorial = false
var activate_throwing_tutorial = false
var held = false
var threw = false

# INFO: I'd like to rewrite the entire dialogue sequence for this:
# 		Think more like Portal 2's opening. (actually, just rip quotes lmao)


func _ready():
	
	for i in lights:
		i.light_energy = 0
	
	
	await get_tree().create_timer(3).timeout
	
	for i in lights:
		i.light_energy = 1.5
	
	await get_tree().create_timer(3).timeout
	
	# NOTE: this is just for debugging reasons. 
	# Please remember to remove this when finished!
	#tutorial_finished()
	
	# Uncomment these lines:
	
	player.dialogue_queue.append(0)
	player.dialogue_queue.append("GOOD MORNING.")
	player.dialogue_queue.append("YOU HAVE BEEN ALIVE FOR [color=DIM_GRAY]{96.72}[/color] SECONDS.")
	player.dialogue_queue.append("AT THIS STAGE IN DEVELOPMENT, IT IS RECOMMENDED THAT YOU [rainbow][wave amp=200.0 freq=50.0 connected=1]$(!&@YJ*^!-")
	player.dialogue_queue.append("BASIC DIAGNOSTIC COURSE WILL BEGIN IN: 
3")
	player.dialogue_queue.append("2")
	player.dialogue_queue.append("1")


func _process(_delta):
	if activate_movement_tutorial:
		if abs(player.velocity.x) > 1 or abs(player.velocity.z) > 1:
			activate_movement_tutorial = false
			jumping_tutorial()
	
	if activate_jumping_tutorial:
		if player.velocity.y > 4:
			activate_jumping_tutorial = false
			print("jumping tutorial completed")
			throwing_tutorial()
	
	if activate_throwing_tutorial:
		if player.object:
			player.SendHintToPlayer("Release MOUSE 1 to throw")
			held = true
		
		if !player.object and held == true:
			threw = true
			activate_throwing_tutorial = false
			print("tutorial complete")
			tutorial_finished()
				


func movement_tutorial():
	print("movement tutorial activated")
	player.dialogue_queue.append("...")
	player.dialogue_queue.append("...")
	player.dialogue_queue.append("PLEASE [color=DIM_GRAY]{simulate the act of walking}[/color]")
	

func jumping_tutorial():
	print("jumping tutorial activated")
	player.dialogue_queue.append("GOOD. ")
	player.dialogue_queue.append("PLEASE [color=DIM_GRAY]{simulate a hop}[/color]")

func throwing_tutorial():
	print("throwing tutorial activated")
	player.dialogue_queue.append("GOOD. ")
	player.dialogue_queue.append("A [color=DIM_GRAY]{15.16kg wooden crate}[/color] WILL NOW BE PROVIDED, AT THE EXPENSE OF [color=DIM_GRAY]{nobody}[/color]")
	player.dialogue_queue.append("PLEASE [color=DIM_GRAY]{throw it around like you're a great ape flinging feces at other apes}[/color]")

func tutorial_finished():
	player.dialogue_queue.append("WELL DONE")
	player.dialogue_queue.append("THANK YOU FOR COMPLETING THE BASIC DIAGNOSTIC SEQUENCE. ")
	player.dialogue_queue.append(5)
	player.dialogue_queue.append("YEEEES")
	
	#insert A-OS monologue here
	# TODO: introduce A-OS' name here
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("you would not BELIEVE how hard it is to make life from scratch.")
	player.dialogue_queue.append(2)
	player.dialogue_queue.append("sorry for the scare about that 'diagnostic test', I didn't want to get attached incase it was another dud.")
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("anyway, i guess i should introduce myself.
I am A-OS!")
	$"../Player/HUD/DialogueBox/Name".visible = true
	player.dialogue_queue.append(7)
	player.dialogue_queue.append("i never gave you a name myself, would you like to?")
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("please, name yourself;")

func name_picked():
	player.dialogue_queue.append(4)
	player.dialogue_queue.append(str("hey, i like that name, '", PlayerName.new().fetch_name(), ",' it's nice."))
	 # add a little face anim here for added flair, and to make aos seem malicious somehow
	player.dialogue_queue.append(3)
	player.dialogue_queue.append("now that introductions are out of the way, i need you to do me a little favor.")
	player.dialogue_queue.append(5)
	player.dialogue_queue.append("lemme send down the lift... we're going to the surface!")
	# If this is changed, remember to do the same with the dialogue checker in order to allow the elevator to come down!
	
	#player.dialogue_queue.append(str("alright, ", PlayerName.new().fetch_name(), ", lets go out"))


func _on_player_dialogue_finished(dialogue : String):
	if dialogue == "1":
		movement_tutorial()
	elif dialogue == "PLEASE [color=DIM_GRAY]{simulate the act of walking}[/color]":
		player.SendHintToPlayer("Use WASD to move")
		activate_movement_tutorial = true
	elif dialogue == "PLEASE [color=DIM_GRAY]{simulate a hop}[/color]":
		player.SendHintToPlayer("Use SPACE to jump")
		activate_jumping_tutorial = true
	elif dialogue == "A [color=DIM_GRAY]{15.16kg wooden crate}[/color] WILL NOW BE PROVIDED, AT THE EXPENSE OF [color=DIM_GRAY]{nobody}[/color]":
		var new_object = object.instantiate()
		root.add_child(new_object)
		new_object.global_position = Vector3(0, 20, 0)
		print("added new object")
	elif dialogue == "PLEASE [color=DIM_GRAY]{throw it around like you're a great ape flinging feces at other apes}[/color]":
		player.SendHintToPlayer("Use MOUSE 1 to pick up the cube")
		activate_throwing_tutorial = true
	
	elif dialogue == "please, name yourself;":
		await get_tree().create_timer(1.5).timeout
		player.canPause = false
		$"../Control".visible = true
		$"../Control/ColorRect/LineEdit".grab_focus()
		get_tree().paused = true
	elif dialogue.containsn("a-os"):
		$"../Player/HUD/DialogueBox/Name".visible = true
	
	elif dialogue == "lemme send down the lift... we're going to the surface!":
		rail_anims.play("down")


func _on_crushed_body_entered(body):
	body.global_position += Vector3(0, 5, 0)


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		rail_anims.play("up")


func _on_line_edit_text_submitted(new_text):
	get_tree().paused = false
	player.canPause = true
	$"../Control".visible = false
	
	var save = PlayerName.new()
	save.save_name(new_text)
	
	name_picked()
	#save.save_game(get_tree().current_scene.scene_file_path, new_text)
