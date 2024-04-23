extends Node3D

@export var projectile: PackedScene
@export var minimum_distance = 15

@onready var raycast = $RayCast3D
@onready var parent = self.get_parent()
@onready var delay = $ShootDelay

var group_name = "projectile"
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#difference is final - initial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in parent.get_children():
		if i.is_in_group("player") and i is CharacterBody3D:
			raycast.target_position =  i.global_position - global_position
			player = i
	
	if raycast.get_collider() == player and delay.is_stopped() and player: 
		#if (player.global_position - self.global_position) <= minimum_distance:
		if global_position.distance_to(player.global_position) <= minimum_distance:
			print_rich("[color=RED]detected")
		
			var new_projectile = projectile.instantiate()
			parent.add_child(new_projectile)
			new_projectile.global_position = global_position
			new_projectile.Shoot(player.position - position)
		
			delay.start()
		
	
	
