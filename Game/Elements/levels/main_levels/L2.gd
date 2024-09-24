extends Node3D

@onready var enemy1 = $EnemySpawnPoint1
@onready var level = $"NavigationRegion3D/level"
@onready var propspawnlocations = $PropSpawnLocations
@onready var player: CharacterBody3D = $Player

@export var enemy_type: PackedScene

var triggered = false
var example_triggered = false
var dialogue_triggered = false


func _ready():
	await get_tree().create_timer(5).timeout
	$Music.play()
	
	await get_tree().create_timer(5).timeout
	
	player.dialogue_queue.append(7)
	player.dialogue_queue.append("did you know i attempt to decorate these places myself?")
	player.dialogue_queue.append(1)
	player.dialogue_queue.append("i try to make it look like what it used to, but i don't know what that looks like!")
	player.dialogue_queue.append(5)
	player.dialogue_queue.append("regardless, i hope you like it")

# Creates enemy when object is grabbed
func _on_trigger_body_entered(body):
	if body.is_in_group("player") and !triggered:
		triggered = true
		
		var newenemy1 = enemy_type.instantiate()
		self.add_child(newenemy1)
		newenemy1.global_position = enemy1.global_position
		player.dialogue_queue.append(5)
		player.dialogue_queue.append("nice job, getting up on that ledge")
		player.dialogue_queue.append(8)
		player.dialogue_queue.append("nice job, tearing my art apart :((((")


# probably remove
func _on_enemy_example_trigger_body_entered(body):
	if body.is_in_group("enemy") and !example_triggered:
		example_triggered = true
		
		player.dialogue_queue.append(1)
		player.dialogue_queue.append("WATCH OUT!")
		player.dialogue_queue.append(5)
		player.dialogue_queue.append("in situations like these, [color=GOLD]cretins can easily be [i]deterred[/i] through blunt force trauma to the head, ")
		player.dialogue_queue.append(3)
		player.dialogue_queue.append("so [color=GOLD][i]throw something at it[/i][/color], stupid!")


# triggers when the player approaches the objective
func _on_dialogue_trigger_body_entered(body):
	if body.is_in_group("player") and !dialogue_triggered:
		dialogue_triggered = true
		player.dialogue_queue.append(7)
		player.dialogue_queue.append("hmm, it's up higher than you")
		player.dialogue_queue.append("try climbing on something to get up")
