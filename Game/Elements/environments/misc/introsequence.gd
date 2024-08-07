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



func _ready():
	
	for i in lights:
		i.light_energy = 0
	
	
	await get_tree().create_timer(3).timeout
	
	for i in lights:
		i.light_energy = 1.5
	
	await get_tree().create_timer(3).timeout
	
	tutorial_finished()
	
	#player.dialogue_queue.append(1)
	#player.dialogue_queue.append("PLEASE COMPLETE THE FOLLOWING DIAGNOSTIC COURSE. ")
	#player.dialogue_queue.append("FAILURE TO DO SO MAY LEAD TO UNEXPECTED SIDE EFFECTS, SUCH AS: 	DEATH")
	#player.dialogue_queue.append("DIAGNOSTIC COURSE IS NOW BEGINNING. ")
	


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
	player.dialogue_queue.append("PLEASE DEMONSTRATE BASIC MOVEMENT CAPABILITIES. ")
	

func jumping_tutorial():
	print("jumping tutorial activated")
	player.dialogue_queue.append("GOOD. ")
	player.dialogue_queue.append("PLEASE DEMONSTRATE VERTICAL MOVEMENT CAPABILITIES. ")

func throwing_tutorial():
	print("throwing tutorial activated")
	player.dialogue_queue.append("GOOD. ")
	player.dialogue_queue.append("YOU WILL NOW BE PROVIDED WITH A 'cube'")
	player.dialogue_queue.append("PLEASE DEMONSTRATE PHYSICAL STRENGTH BY HOLDING THE 'cube'")

func tutorial_finished():
	player.dialogue_queue.append("THANK YOU FOR COMPLETING THE DIAGNOSTIC SEQUENCE. ")
	player.dialogue_queue.append(0)
	player.dialogue_queue.append("YEEEES")
	
	#insert A-OS monologue here
	# TODO: introduce A-OS' name here
	player.dialogue_queue.append("you would not BELIEVE how hard it is to make life from scratch.")
	player.dialogue_queue.append("sorry for the scare about that 'diagnostic test', I didn't want to get attached incase it was another dud.")
	player.dialogue_queue.append("anyway, i want to get to know you")
	player.dialogue_queue.append("pick a name for yourself: ")

func name_picked():
	player.dialogue_queue.append(str("hey, i like that name, '", PlayerName.new().fetch_name(), ",' it's nice."))
	player.dialogue_queue.append("...")
	player.dialogue_queue.append("this room is pretty boring, huh.")
	player.dialogue_queue.append(str("alright, ", PlayerName.new().fetch_name(), ", lets go out"))
	player.dialogue_queue.append("i just lined something up that could be fun!")
	player.dialogue_queue.append("i just remembered that you require food to live, and i don't have any on standby")
	player.dialogue_queue.append("lets go find some")
	player.dialogue_queue.append("lemme send down the lift... we're going to the surface!")
	# If this is changed, remember to do the same with the dialogue checker in order to allow the elevator to come down!

# i just realised you can't eat, because i never gave you a mouth
# oh well, guess you'll starve
# on the bright side, it'll take you approximately 4 years to starve
# i'll just revive you when that happens anyway, <name>!

func _on_player_dialogue_finished(dialogue):
	if dialogue == "DIAGNOSTIC COURSE IS NOW BEGINNING. ":
		movement_tutorial()
	elif dialogue == "PLEASE DEMONSTRATE BASIC MOVEMENT CAPABILITIES. ":
		player.SendHintToPlayer("Use WASD to move")
		activate_movement_tutorial = true
	elif dialogue == "PLEASE DEMONSTRATE VERTICAL MOVEMENT CAPABILITIES. ":
		player.SendHintToPlayer("Use SPACE to jump")
		activate_jumping_tutorial = true
	elif dialogue == "YOU WILL NOW BE PROVIDED WITH A 'cube'":
		var new_object = object.instantiate()
		root.add_child(new_object)
		new_object.global_position = Vector3(0, 20, 0)
		print("added new object")
	elif dialogue == "PLEASE DEMONSTRATE PHYSICAL STRENGTH BY HOLDING THE 'cube'":
		player.SendHintToPlayer("Use MOUSE 1 to pick up the cube")
		activate_throwing_tutorial = true
	
	elif dialogue == "pick a name for yourself: ":
		player.canPause = false
		$"../Control".visible = true
		$"../Control/ColorRect/LineEdit".grab_focus()
		get_tree().paused = true
	
	elif dialogue == "lemme send down the lift... we're going to the surface":
		rail_anims.play("down")
	
	
	



func _on_crushed_body_entered(body):
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(99999)



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






