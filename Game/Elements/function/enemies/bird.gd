extends CharacterBody3D

@export var speed: float = 5
@export var attack_dmg: float = 3
@export var attack_dist: float = 12
@export var attack_speed: float = 200
@export var retreat_multiplier: float = 2

@onready var ray = $Ray
@onready var mesh = $bird
@onready var push = $Push

@onready var anims = $bird/AnimationPlayer
@onready var corpse = $"bird/Mesh-rigid"
@onready var corpse_col = $"bird/Mesh-rigid/CollisionShape3D"

var player
var attack_cooldown : bool = false

# -- Behavior Context
# The bird will fly towards the player using very loosely adding velocity for added variation
# When close enough, they no longer fly loosely and instead charge the player directly
# When the bird damages the player, they retreat back
#
# My goal is that the bird is hard to hit when they're far away and moving loosely, but very easy to hit when lunging at the player
# Which will be the player's time to strike (if they play it smart)


func _ready():
	# General initialisation of stuff
	
	anims.play("idle")
	corpse.visible = false
	corpse_col.disabled = true
	
	$Info.damage_from_collision = attack_dmg
	
	# Find the player in the scene
	for i in get_parent().get_children():
		if i.is_in_group("player"):
			player = i
			# This is likely the worst way to find the player script in-game
			# I could have used an export variable, but that'd require
			# manually setting a variable for every bird

func _physics_process(delta):
	# Set the ray position to the player's position every frame
	if is_instance_valid(player): # Not doing this causes errors
		ray.global_position = global_position
		ray.target_position = player.global_position - global_position
	
	# Checks if the bird can see the player, and start flying towards them
	if ray.is_colliding():
		if is_instance_valid(ray.get_collider()) and is_instance_valid(ray):
			if ray.get_collider().is_in_group("player"):
				mesh.look_at(ray.get_collider().global_position, Vector3.UP, true)
				
				var distance = global_position.distance_to(ray.get_collider().global_position) / 5
				velocity += ((ray.get_collider().global_position - global_position).normalized() * speed * distance) * delta 
				velocity += Vector3(0, speed / 2, 0) * delta
				
				
				# Waits for the bird to be close enough to start charging them
				if global_position.distance_to(ray.get_collider().global_position) < attack_dist:
					if !attack_cooldown: # If the bird hasn't hit the player, change them
						velocity = ((ray.get_collider().global_position - global_position).normalized() * speed * attack_speed) * delta
					else: # Once they hit the player, retreat - Rinse and repeat
						velocity = -((ray.get_collider().global_position - global_position).normalized() * speed * (attack_speed * retreat_multiplier)) * delta
	
	
	# Push itself away from nearby objects (to prevent the bird from getting stuck)
	if push.has_overlapping_bodies():
		for i in push.get_overlapping_bodies():
			if i != self and !i.is_in_group("player"): # Don't push itself away from the player
				velocity -= ((i.global_position - self.global_position) * delta) * 10
	
	move_and_slide()
	

# External signal that handles death
func _on_info_death():
	# Create a corpse of the bird
	corpse.visible = true
	corpse.freeze = false
	corpse_col.disabled = false
	corpse.reparent(get_parent())
	
	queue_free() # Deletes itself

# External signal that checks if the bird dealt damage to the player
func _on_info_dealt_damage():
	# attack_cooldown handles when the bird should retreat from the player
	attack_cooldown = true
	await get_tree().create_timer(2).timeout
	attack_cooldown = false
