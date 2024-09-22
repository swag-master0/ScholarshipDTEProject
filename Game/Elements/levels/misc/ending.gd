extends Node3D

@onready var player = $Player
@onready var black = $Black

func _ready():
	await get_tree().create_timer(10).timeout
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(1).timeout
	black.queue_free()
	
