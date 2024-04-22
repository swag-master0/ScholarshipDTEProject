extends Node3D

@export var vel_CharacterBody = 60
@export var vel_RigidBody = 2000


func _on_trigger_body_entered(body):
	if body is CharacterBody3D:
		body.velocity.y = vel_CharacterBody
	elif body is RigidBody3D:
		body.apply_force(Vector3(0, vel_RigidBody, 0))
	else:
		print_rich("[rainbow][font_size=50]how the fuck")
