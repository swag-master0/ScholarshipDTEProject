extends RigidBody3D

@onready var initial_pos = self.global_position

@onready var impact1 = $Impact01
@onready var impact2 = $Impact02

# anti softlock, in case the objective item falls out of the world
func _process(_delta):
	if self.global_position.y < -500:
		self.global_position = initial_pos
		self.set_freeze_enabled(true)
		self.set_freeze_enabled(false)
		
		push_error("Reset the location of the objective item, due to potential softlock")
	
	



func _on_body_entered(_body):
	var vel = abs(self.get_linear_velocity())
	var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
	
	if magnitude > 2.5:
		impact1.play()
		impact2.play()
