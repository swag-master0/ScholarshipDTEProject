extends Node3D

@export var projectile: PackedScene

@onready var raycast = $RayCast3D
@onready var parent = self.get_parent()
@onready var delay = $ShootDelay

var group_name = "projectile"
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in parent.get_children():
		#print(i)
		if i.is_in_group("player") and i is CharacterBody3D:
			raycast.target_position =  i.global_position - global_position
			player = i
	
	if raycast.get_collider() == player and delay.is_stopped():
		print_rich("[color=RED]detected")
		
		var new_projectile = projectile.instantiate()
		parent.add_child(new_projectile)
		new_projectile.global_position = Vector3(0, 2, 0)
		new_projectile.Shoot(player.position - position)
		
		delay.start()
		
	
	
