extends RigidBody3D

@onready var ray = $RayCast3D
@onready var timer = $Timer
@export var force_speed : float = 25
@export var distance : float = 5

var can_attack = true

func _process(delta):
	ray.global_position = global_position
	
	for i in self.get_parent().get_children():
		if i.is_in_group("player"):
			ray.target_position = i.global_position - global_position
	
	
	if ray.is_colliding() and ray.get_collider().is_in_group("player"):
		var player = ray.get_collider()
		
		
		if self.global_position.distance_to(player.global_position) < distance:
			Attack(player.global_position, self.global_position)
	

func Attack(final, initial):
	if can_attack:
		can_attack = false
		
		# attacking player
		self.apply_impulse((final - initial).normalized() * force_speed)
		timer.start()
		
	

func _on_timer_timeout():
	can_attack = true


func _on_info_death():
	print("died")
	self.queue_free()



