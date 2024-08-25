extends Node3D

signal Triggered
# INFO: connect to triggered to know if the button is pressed

func _on_hitbox_body_entered(body):
	if body is RigidBody3D:
		Triggered.emit()
