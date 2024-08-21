extends RigidBody3D

@onready var ray = $RayCast3D
@onready var timer = $Timer
@export var force_speed : float = 25
@export var distance : float = 5

var can_attack = true

func _process(_delta):
	ray.global_position = global_position
	
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			ray.target_position = i.global_position - global_position
	
	
	if ray.is_colliding() and is_instance_valid(ray.get_collider()): 
		if ray.get_collider().is_in_group("player"):
			var player = ray.get_collider()
			
			
			if self.global_position.distance_to(player.global_position) < distance:
				Attack(player.global_position, self.global_position)
	


func _on_enemy_detection_body_entered(body):
	if body.is_in_group("enemy"):
		Attack(body.global_position, self.global_position)




func Attack(final, initial):
	if can_attack:
		can_attack = false
		
		$AnimationPlayer.play("attack")
		# insert sfx here
		
		self.apply_impulse(((final - initial).normalized() * force_speed) + Vector3(0, 5, 0))
		timer.start()
		
	

func _on_timer_timeout():
	can_attack = true


func _on_info_death():
	print("died")
	self.queue_free()





