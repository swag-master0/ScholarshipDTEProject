extends Node3D

@export var bird: PackedScene
@onready var locations = $Spawns
@onready var spawn_cooldown = $SpawnCooldown

var triggered: bool = false


func _ready():
	pass
	# dialogue

func _on_trigger_body_entered(body):
	if !triggered:
		if body.is_in_group("player"):
			spawn_cooldown.start()
			triggered = true
			print("triggered")
			
			# initial spawns
			# add dialogue here too
			for i in range(20):
				_on_spawn_cooldown_timeout()


func _on_spawn_cooldown_timeout():
	if triggered:
		var new_bird = bird.instantiate()
		add_child(new_bird)
		new_bird.global_position = locations.get_children().pick_random().global_position
		
		print("bird spawned")
