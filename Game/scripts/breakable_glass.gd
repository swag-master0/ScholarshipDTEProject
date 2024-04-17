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
	if body is RigidBody3D:
		var mag = info.calculateMagnitude(body)
		
		health = health - info.calculateDamage(mag)
		"""
		var vel = body.get_linear_velocity()
		
		# convert negative numbers to positive, or else square root returns 'not a number'
		if vel.x < 0:
			vel.x = vel.x * -1
		if vel.y < 0:
			vel.y = vel.y * -1
		if vel.z < 0:
			vel.z = vel.z * -1
		
		var magnitude = sqrt(vel.x + vel.y + vel.z)
		
		if magnitude > 1:
			var damage = magnitude * body.mass
			health = health - damage
			
			print(damage)
			#print(health)
		"""


func _process(delta):
	if health <= 0:
		Toggle(false)
		pane.visible = false
		staticbody.set_collision_layer_value(1, false)
		staticbody.set_collision_mask_value(1, false)
