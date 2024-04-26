extends CharacterBody3D

#@export var speed = 200
@export var damage = 5
@onready var info = $Info

var speed = Vector3()

func Shoot(direction):
	speed = direction.normalized()

func _process(delta):
	global_position += lerp(Vector3(), speed, 0.2)



func _on_hitbox_body_entered(body):
	# checks if the object colliding is itself
	if body == self:
		return
	
	"""
	# scan if body has a info node
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(damage)
			self.queue_free()
	"""
	
	if (body is RigidBody3D) or (body is StaticBody3D):
		self.queue_free()
	else:
		pass

