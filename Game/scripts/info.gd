extends Node3D

signal takeDamage
signal death

var projectileDamage = 3
@onready var timer = $Timeout

@export_group("Variables")
@export var health : float = 5
@export var damage_from_collision : float = 3
@export var invincibility_frames : float = 0.5

@export_group("Damages")
@export var TakeDamageFromRigidBodies : bool = true
@export var TakeDamageFromProjectiles : bool = true
@export var DamagePlayerOnPlayerCollision : bool = true

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
func Damage(damage: float):
	
	if timer.is_stopped():
		health -= damage
		emit_signal("takeDamage") # TakeDamage is to be used to indicate to objects whether they're taking damage, use to activate vfx and sfx
		timer.start() # The timer acts as a sort of 'invincibility frames'
	
	
	if health <= 0:
		emit_signal("death") # Death is used to indicate if a object dies
	
	# These signals can be found in the 'Signals' menu on the info node, and can call functions when they get called
	# Use this to update health bars, play SFX and VFX, ect...



# NOTE: This node has a hitbox. Please use that instead of creating a new hitbox
func _on_hitbox_body_entered(body):
	# The colliding object is a Rigid Body
	if body is RigidBody3D and TakeDamageFromRigidBodies:
		# Damage function emits the signal of taking damage and emits death
		Damage(calculateDamageBasedOnVelocity(body))
	
	
	# The colliding object is a Projectile
	if body is CharacterBody3D and body.is_in_group("projectile") and TakeDamageFromProjectiles:
		Damage(projectileDamage)
		body.queue_free() # delete projectile
	
	# The colliding object is the player
	if body is CharacterBody3D and body.is_in_group("player") and DamagePlayerOnPlayerCollision:
		
		# Search for the player's info node and call the Damage function on that
		for i in body.get_children():
			if i.is_in_group("info"):
				i.Damage(damage_from_collision)










