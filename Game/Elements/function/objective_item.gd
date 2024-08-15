extends RigidBody3D

@onready var initial_pos = self.global_position


# anti softlock, in case the objective item falls out of the world
func _process(_delta):
	if self.global_position.y < -500:
		self.global_position = initial_pos
		self.set_freeze_enabled(true)
		self.set_freeze_enabled(false)
		
		push_error("Reset the location of the objective item, due to potential softlock")
	
	"""
	if self.get_parent().get_parent().is_in_group("player"):
		pointer.visible = true
	else:
		pointer.visible = false
	"""
