extends RigidBody3D

@onready var shader = $MeshInstance3D.mesh.material.next_pass


# Called when the node enters the scene tree for the first time.
func _ready():
	shader.set_shader_parameter("strength", 0)


func SelectableVisual(value):
	var targetted = value
	if targetted:
		shader.set_shader_parameter("strength", 1)
		print("yes")
	else:
		shader.set_shader_parameter("strength", 0)
		print("no")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
