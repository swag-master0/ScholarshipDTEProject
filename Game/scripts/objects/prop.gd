extends RigidBody3D

@onready var sound = $Sound

func _on_body_entered(_body):
	if !sound.is_playing():
		sound.play()