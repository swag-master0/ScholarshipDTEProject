extends RigidBody3D

@export var explosion: PackedScene

var magnitude = 0
var minimum = 2.5

func _on_area_3d_body_entered(body):
	var vel = self.get_linear_velocity()
	
	# convert negative numbers to positive, or else square root returns 'not a number'
	if vel.x < 0:
		vel.x = vel.x * -1
	if vel.y < 0:
		vel.y = vel.y * -1
	if vel.z < 0:
		vel.z = vel.z * -1
	
	var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
	
	if ((body is StaticBody3D) or (body is RigidBody3D and body != self) or (body is CharacterBody3D)) and (magnitude > minimum):
		explode()
	



func explode():
	var created_explosion = explosion.instantiate()
	self.get_parent().add_child(created_explosion)
	created_explosion.position = position
	
	self.queue_free()


