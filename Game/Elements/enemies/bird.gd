extends CharacterBody3D

@export var speed: float = 5
@export var attack_dmg: float = 5
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
	anims.play("idle")
	corpse.visible = false
	corpse_col.disabled = true
	
	$Info.damage_from_collision = attack_dmg
	
	for i in get_parent().get_children():
		if i.is_in_group("player"):
			player = i

func _physics_process(delta):
	if is_instance_valid(player):
		ray.global_position = global_position
		ray.target_position = player.global_position - global_position
	
	
	if ray.is_colliding():
		if ray.get_collider().is_in_group("player"):
			mesh.look_at(ray.get_collider().global_position, Vector3.UP, true)
			
			var distance = global_position.distance_to(ray.get_collider().global_position) / 5
			velocity += ((ray.get_collider().global_position - global_position).normalized() * speed * distance) * delta 
			velocity += Vector3(0, speed / 2, 0) * delta
			
			# Close enough to attack
			if global_position.distance_to(ray.get_collider().global_position) < attack_dist:
				if !attack_cooldown:
					velocity = ((ray.get_collider().global_position - global_position).normalized() * speed * attack_speed) * delta
				else:
					velocity = -((ray.get_collider().global_position - global_position).normalized() * speed * (attack_speed * retreat_multiplier)) * delta
	
	
	# Push itself away from nearby objects (to prevent the bird from getting stuck)
	if push.has_overlapping_bodies():
		for i in push.get_overlapping_bodies():
			if i != self and !i.is_in_group("player"):
				velocity -= ((i.global_position - self.global_position) * delta) * 10
	
	move_and_slide()

func _on_info_death():
	corpse.visible = true
	corpse.freeze = false
	corpse_col.disabled = false
	corpse.reparent(get_parent())
	queue_free()

func _on_info_dealt_damage():
	attack_cooldown = true
	await get_tree().create_timer(2).timeout
	attack_cooldown = false
