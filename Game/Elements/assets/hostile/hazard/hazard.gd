extends Node3D

@export var damage : float = 4
@export var push_force : float = 20


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y += push_force
	
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(damage)
