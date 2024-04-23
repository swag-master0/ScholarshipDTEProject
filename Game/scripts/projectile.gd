extends CharacterBody3D

@export var speed = 200
@export var accel = 1

@onready var info = $Info


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func Shoot(direction):
	var vel = direction.normalized()
	
	var tree = get_tree().create_tween()
	tree.tween_property(self, "position", vel * speed, 30)
	
	print(velocity)
	


func _on_hitbox_body_entered(body):
	print(body)
	
	# scan if body has a info node
	for i in body.get_children():
		if i.is_in_group("info"):
			i.Damage(5)
			self.queue_free()
	
	if (body is RigidBody3D) or (body is StaticBody3D):
		self.queue_free()
	else:
		pass


