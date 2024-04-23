extends Node3D

signal takeDamage
signal death

@onready var timer = $Timeout
@export var health : float
#@export var disabled : bool
#@export var damage : int


func calculateDamageBasedOnVelocity(body):
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
		
		if magnitude > 1.5:
			return magnitude # returns damage
		else:
			return 0


# damage is the amount of damage the entity should take
func Damage(damage):
	
	if timer.is_stopped():
		health -= damage
		emit_signal("takeDamage") # TakeDamage is to be used to indicate to objects whether they're taking damage, use to activate vfx and sfx
		timer.start()
	
	
	if health <= 0:
		emit_signal("death") # Death is used to indicate if a object dies


