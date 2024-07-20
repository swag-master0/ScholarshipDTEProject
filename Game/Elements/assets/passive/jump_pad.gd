extends Node3D

@export var vel_CharacterBody = 60
@export var vel_RigidBody = 2000


@onready var up = $Direction.global_position - self.global_position


func _on_trigger_body_entered(body):
	
	if body is CharacterBody3D:
		body.velocity = up * vel_CharacterBody

		#velocity.y = 30
		#velocity = transform.basis.z.normalized()*speed
	
	elif body is RigidBody3D:
		body.set_freeze_enabled(true)
		body.set_freeze_enabled(false)
		body.apply_force(up * vel_RigidBody)
		
	else:
		print_rich("[rainbow][font_size=50]how the fuck")


