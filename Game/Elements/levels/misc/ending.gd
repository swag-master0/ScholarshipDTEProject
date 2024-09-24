extends Node3D

@onready var player = $Player
@onready var black = $Black
@onready var particles = $Particles



func _ready():
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	await get_tree().create_timer(10).timeout
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(1).timeout
	black.queue_free()
	

func _process(_delta):
	particles.global_position = player.global_position + Vector3(-15, 0, 0)
