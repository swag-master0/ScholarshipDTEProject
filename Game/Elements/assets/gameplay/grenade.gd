extends RigidBody3D

#@export var speed = 200

@export var explosion : PackedScene
@export var damage = 5
@export var iscarried = false

var speed = Vector3()



func _process(_delta):
	if $Timer.is_stopped():
		$Timer.start()
	
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("projectile")
	
	$AnimationPlayer.speed_scale = 10 - ($Timer.time_left * 2)


func Shoot(direction):
	self.apply_force(direction.normalized() * 1000)


func explode():
	var created_explosion = explosion.instantiate()
	
	if self.get_parent().is_in_group("player"):
		self.get_parent().get_parent().add_child(created_explosion)
		
	else:
		self.get_parent().add_child(created_explosion)
		
	created_explosion.position = position
	#created_explosion.set_collision_layer_value(1, true)
	#created_explosion.set_collision_mask_value(1, true)
	
	self.queue_free()


func _on_timer_timeout():
	explode()
