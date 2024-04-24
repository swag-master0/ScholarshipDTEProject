extends CharacterBody3D

@export var projectile: PackedScene
@export var minimum_distance = 15

@onready var raycast = $RayCast3D
@onready var parent = self.get_parent()
@onready var delay = $ShootDelay
@onready var info = $Info
@onready var spawnpoint = $MeshInstance3D/MeshInstance3D2

var group_name = "projectile"
var player = null




func _process(_delta):
	# Finds the player's position, and sends a raycast there
	for i in parent.get_children():
		if i.is_in_group("player") and i is CharacterBody3D:
			raycast.target_position =  i.global_position - global_position
			player = i
			
	
	# Checks if the player is in line of sight, delay isn't going, and player is close enough to the sentry
	if raycast.get_collider() == player and player: 
		
		$MeshInstance3D.look_at(player.global_position)
		
		if global_position.distance_to(player.global_position) <= minimum_distance and delay.is_stopped():
			
			# fires projectile towards player
			
			var new_projectile = projectile.instantiate()
			parent.add_child(new_projectile)
			new_projectile.global_position = spawnpoint.global_position
			new_projectile.Shoot(player.position - position)
		
			delay.start()




func _on_info_take_damage():
	pass # Replace with function body.


func _on_info_death():
	self.queue_free() # delete itself upon death
