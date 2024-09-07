extends Node3D

@export var bomber : PackedScene
@onready var spawn_position = $SpawnPosition
@onready var player = $Player
@onready var egg_area = $EggArea

var bomber_present = false

func _ready():
	player.dialogue_queue.append("fag")

func spawnBomber():
	var new_bomber = bomber.instantiate()
	self.add_child(new_bomber)
	new_bomber.global_position = spawn_position.global_position


func _process(_delta):
	# Checking if a bomber is in the scene
	# This is perhaps the WORST way to do this... but I unfortunately don't care
	bomber_present = false
	
	for i in get_children():
		if i.is_in_group("bomber"):
			bomber_present = true
	
	# Checking if the player is holding the bomber
	if is_instance_valid(player.object):
		if player.object.is_in_group("bomber"):
			bomber_present = true
	
	
	if !bomber_present:
		spawnBomber()
	
	
	for i in egg_area.get_overlapping_bodies():
		if i is RigidBody3D and !i.is_in_group("bomber"):
			i.apply_force(Vector3(0, 0, 200))
	
