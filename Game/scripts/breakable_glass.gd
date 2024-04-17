extends Node3D

@onready var main = $glass
@onready var pane = $"glass/Pane "
@onready var staticbody = $"glass/Pane /StaticBody3D"

@export var health = 10
@export var threshold = 5

func Toggle(value : bool):
	for i in range(main.get_children().size()):
		if main.get_children()[i] is RigidBody3D:
			main.get_children()[i].set_freeze_enabled(value)
			main.get_children()[i].visible = !value
			print("success")

# Called when the node enters the scene tree for the first time.
func _ready():
	Toggle(true)

func _on_hitbox_body_entered(body):
	if body is RigidBody3D:
		print(body.get_linear_velocity())
		var vel = body.get_linear_velocity()
		if (vel.x > threshold or vel.x < -threshold) or (vel.y > threshold or vel.y < -threshold) or (vel.z > threshold or vel.z < -threshold): #fucking retarded
			Toggle(false)
			pane.visible = false
			staticbody.set_collision_layer_value(1, false)
			staticbody.set_collision_mask_value(1, false)
			
