extends Node3D

signal Triggered


func _on_hitbox_body_entered(body):
	if body is RigidBody3D:
		emit_signal("Triggered")
