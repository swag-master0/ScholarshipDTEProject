extends Node3D

@onready var main = $glass
@onready var pane = $"glass/Pane "
@onready var staticbody = $"glass/Pane /StaticBody3D"

@onready var health = $Info.health
@onready var info = $Info


func Toggle(value : bool):
	for i in range(main.get_children().size()):
		if main.get_children()[i] is RigidBody3D:
			main.get_children()[i].set_freeze_enabled(value)
			main.get_children()[i].visible = !value



# Called when the node enters the scene tree for the first time.
func _ready():
	Toggle(true)



func _on_hitbox_body_entered(body):
	if body is RigidBody3D and !(body.get_parent() == self):
		info.Damage(info.calculateDamageBasedOnVelocity(body))
		
		print(info.calculateDamageBasedOnVelocity(body))
		


func _on_info_death():
	Toggle(false)
	pane.visible = false
	staticbody.set_collision_layer_value(1, false)
	staticbody.set_collision_mask_value(1, false)
	#pass # Replace with function body.
