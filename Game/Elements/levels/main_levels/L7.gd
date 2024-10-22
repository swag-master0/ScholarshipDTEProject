extends Node3D

@onready var area = $Pain
@onready var player = $Player

@export var player_floor_damage : float = 1
@export var player_fling_velocity : float = 35
@export var enemy_floor_damage : float = 9999
@export var prop_fling_velocity : float = 50


func _ready():
	await get_tree().create_timer(5).timeout
	player.dialogue_queue.append("the ground's not completely solid, and can leak moisture through")
	player.dialogue_queue.append("this next area's kinda flooded")
	player.dialogue_queue.append("don't jump in, it's kinda dangerous")

func _process(_delta):
	for i in area.get_overlapping_bodies():
		if i.is_in_group("projectile"):
			i.apply_force(Vector3(0, prop_fling_velocity, 0))
		
		# TODO: test this
		if i.is_in_group("enemy"):
			for o in i.get_children():
				if o.is_in_group("info"):
					o.Damage(enemy_floor_damage)


func _on_pain_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y = player_fling_velocity
		
		for i in body.get_children():
			if i.is_in_group("info"):
				i.Damage(player_floor_damage)
	
