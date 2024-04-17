extends Node3D

@export var health : int
@export var disabled : bool


func calculateMagnitude(body):
	if body is RigidBody3D:
		var vel = body.get_linear_velocity()
		
		# convert negative numbers to positive, or else square root returns 'not a number'
		if vel.x < 0:
			vel.x = vel.x * -1
		if vel.y < 0:
			vel.y = vel.y * -1
		if vel.z < 0:
			vel.z = vel.z * -1
		
		var magnitude = sqrt(vel.x + vel.y + vel.z)
		return magnitude

func calculateDamage(mag):
	if mag > 1.5:
		return mag
	else:
		return 0
