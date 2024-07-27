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
	
	sequence1()
	


func _process(_delta):
	sequence1()
	sequence2()
	sequence3()
	sequence4()
	sequence5()

# introduction:
func sequence1():
	await get_tree().create_timer(3).timeout
	
	player.dialogue_queue.append("Please complete a basic diagnostic course")
	player.dialogue_queue.append("This course aims to analyse your general competence. ")
	player.dialogue_queue.append("Lets begin: ")
	
	#sequence2()


# teach movement:
func sequence2():
	player.dialogue_queue.append("To start, take a few steps")
	player.SendHintToPlayer("WASD - Walk")
	
	
	if abs(player.velocity.x) > 5 or abs(player.velocity.z) > 5:
		pass
	else:
		return
	


# teach jumping
func sequence3():
	player.dialogue_queue.append("Good.")
	player.dialogue_queue.append("Next, please indicate capability of vertical mobility")
	await get_tree().create_timer(5).timeout
	player.SendHintToPlayer("Space - Jump")
	
	await player.velocity.y
	print("jump")
	sequence4()


# give the player a box or something and teach them to throw it
func sequence4():
	pass


# drop the rail down, to begin game
func sequence5():
	pass
	#rail_anims.play("down")
	




func _on_crushed_body_entered(body):
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(99999)
