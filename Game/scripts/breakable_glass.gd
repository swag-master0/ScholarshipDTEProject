extends Node3D

@onready var main = $glass

@export var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(main.get_children().size()):
		if main.get_children()[i] is RigidBody3D:
			main.get_children()[i].set_freeze_enabled(true)
			main.get_children()[i].visible = false
			print("success")


func damage(damage: Damage):
	health = health - damage.attack_damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
