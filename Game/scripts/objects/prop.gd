extends RigidBody3D

@export var grabbable : bool = false
@onready var sound = $Sound

var ungrabbable_group = "ungrabbable"

func _on_body_entered(_body):
	if !sound.is_playing():
		sound.play()

func _ready():
	if grabbable:
		self.add_to_group(ungrabbable_group)
