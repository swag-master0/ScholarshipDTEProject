extends Node3D


@export var enable_col : bool = false
@onready var full_collisions = $CollisionsFull


func _process(_delta):
	if enable_col == true:
		full_collisions.disabled = false
	else:
		full_collisions.disabled = true
	

