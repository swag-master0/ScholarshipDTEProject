extends Node3D

var player_has_objective = false
var triggered = false
var dialogue_triggered = false
#var spawns : int = 0

var amount_to_spawn = 20
var amount_to_spawn_bombers = 4

@onready var doors = $Doors
@onready var spawnpoints = $Spawnpoints
@onready var player = $Player


@export var enemy : PackedScene
@export var bombers : PackedScene


# TODO change this so the fight activates when the player returns with objective
# also, make enemies appear in waves

func _ready():
	await get_tree().create_timer(5).timeout
	
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("from what i've been able to see, this area [i]shouldn't[/i] have that many creatures")
	player.dialogue_queue.append(4)
	player.dialogue_queue.append("i wonder why")
	
	for i in doors.get_children():
		i.global_position += Vector3(0, 50, 0)
		i.visible = false




func _on_trigger_body_entered(body):
	if body.is_in_group("player") and !triggered and player_has_objective:
		triggered = true
		
		if !dialogue_triggered:
			dialogue_triggered = true
			
			player.dialogue_queue.append(1)
			player.dialogue_queue.append("HEADS UP!")
		
		#for i in doors.get_children():
		#	i.global_position -= Vector3(0, 50, 0)
		#	i.visible = true
		
		for i in range(amount_to_spawn):
			var desired_enemy = enemy
			
			var new_enemy = desired_enemy.instantiate()
			self.add_child(new_enemy)
			
			new_enemy.global_position = spawnpoints.get_children()[randi_range(1, spawnpoints.get_children().size()) - 1].global_position
		
		for i in range(amount_to_spawn_bombers):
			var desired_enemy = bombers
			
			var new_enemy = desired_enemy.instantiate()
			self.add_child(new_enemy)
			
			new_enemy.global_position = spawnpoints.get_children()[randi_range(1, spawnpoints.get_children().size()) - 1].global_position
			


func _on_objective_area_body_entered(body):
	if body.is_in_group("player") and !triggered and !player_has_objective:
		player_has_objective = true
		
		player.dialogue_queue.append(7)
		player.dialogue_queue.append("i dunno what it is, but something's not right")
		player.dialogue_queue.append(1)
		player.dialogue_queue.append(str("[i]be careful, ", PlayerName.new().fetch_name(), "!"))
