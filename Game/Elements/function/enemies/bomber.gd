extends RigidBody3D

@export var speed = 300

@export var explosion : PackedScene 
@onready var raycast = $RayCast3D
@onready var fuse = $FuseTime
@onready var audio = $Buildup
@onready var audio2 = $Buildup2
@onready var glow = $Glow



var player
var fuse_triggered = false

# navigating
func _physics_process(_delta):
	raycast.global_position = global_position
	raycast.global_rotation = Vector3(0, 0, 0)
	
	for i in self.get_parent_node_3d().get_children():
		if i is CharacterBody3D and i.is_in_group("player"):
			player = i
			raycast.target_position = player.global_position - global_position


func _process(delta):
	if raycast.get_collider() == player and get_colliding_bodies().size() > 0:
		self.apply_impulse(((player.global_position - global_position).normalized() * delta) * speed)


func _on_trigger_body_entered(body):
	if body.is_in_group("player") and fuse_triggered == false:
		fuse_triggered = true
		fuse.start()
		audio.play()
		audio2.play()
		glow.light_energy = 1


func _on_delay_timeout():
	var created_explosion = explosion.instantiate()
	self.get_parent().add_child(created_explosion)
	created_explosion.position = position
	
	self.queue_free()
