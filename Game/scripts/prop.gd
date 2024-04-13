extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print($Collision.get_shape_owners())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Collision.get_shape_owners())
