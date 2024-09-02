extends Node3D

signal takeDamage
signal death
signal dealtDamage

var projectileDamage = 3
var hasDied = false

@onready var timer = $Timeout
@onready var sound_hurt = $Hurt
@onready var sound_kill = $Kill
@onready var particles = $HurtParticles2


@export_group("Variables")
@export var health : float = 5
@export var max_health : float = 5
@export var damage_from_collision : float = 3
@export var invincibility_frames : float = 0.5

@export_group("Options")
@export var TakeDamageFromRigidBodies : bool = true
@export var DamagePlayerOnPlayerCollision : bool = true
@export var PlayKillSound : bool = false
@export var PlayHurtSound : bool = false
@export var DisplayDamageParticles : bool = false
@export var DisplayHealthBar : bool = true
@export var MagnitudeThreshold : float = 0.5



func calculateDamageBasedOnVelocity(body):
	if body is RigidBody3D:
		var vel = abs(body.get_linear_velocity())
		
		var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
		
		if magnitude > MagnitudeThreshold:
			return magnitude
		else:
			return 0


# damage is the amount of damage the entity should take
func Damage(damage: float):
	if timer.is_stopped():
		
		# doesn't play the hurt sfx if it takes a miniscule amount of damage
		if health - (health - damage) > 1:
			if PlayHurtSound:
				sound_hurt.pitch_scale = randf_range(75, 125) / 100
				sound_hurt.play()
			
			if DisplayDamageParticles:
				particles.emitting = true
			
			takeDamage.emit() # TakeDamage is to be used to indicate to objects whether they're taking damage, use to activate vfx and sfx
		
		health -= damage
		
		timer.start() # The timer acts as a sort of 'invincibility frames'
	
	
	if health <= 0:
		if !hasDied:
			hasDied = true
			
			if PlayKillSound and sound_kill != null:
				sound_kill.pitch_scale = randf_range(75, 125) / 100
				sound_kill.play()
				sound_kill.reparent(self.get_parent().get_parent())
			
			death.emit() # Death is used to indicate if a object dies
	
	# These signals can be found in the 'Signals' menu on the info node, and can call functions when they get called
	# They're used to display damage effects, ect


# NOTE: This node has a hitbox. Please use that instead of creating a new hitbox
func _on_hitbox_body_entered(body):
	if body is RigidBody3D and TakeDamageFromRigidBodies:
		Damage(calculateDamageBasedOnVelocity(body))
	
	if body is CharacterBody3D and body.is_in_group("player") and DamagePlayerOnPlayerCollision:
		for i in body.get_children():
			if i.is_in_group("info"):
				i.Damage(damage_from_collision)
				dealtDamage.emit()
