extends RigidBody3D

@export var explosion: PackedScene

var minimum = 3.5

func _on_area_3d_body_entered(body):
	var vel = self.get_linear_velocity()
	
	# convert negative numbers to positive, or else square root returns 'not a number'
	vel = abs(vel)
	
	var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
	
	if magnitude > minimum and !(body.is_in_group("player")):
		$Timer.start(0.2)

func _on_timer_timeout():
	explode()

func explode():
	var created_explosion = explosion.instantiate()
	self.get_parent().add_child(created_explosion)
	created_explosion.position = position
	
	self.queue_free()
