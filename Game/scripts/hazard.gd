extends Node3D

@export var damage : float = 2



func _on_area_3d_body_entered(body):
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(damage)
