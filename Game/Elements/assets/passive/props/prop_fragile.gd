extends RigidBody3D

@export var ungrabbable : bool = false
@export var force_to_break : float = 2
@onready var sound = $Sound

var ungrabbable_group = "ungrabbable"

func _on_body_entered(body):
	var vel = self.get_linear_velocity()
	
	# convert negative numbers to positive, or else square root returns 'not a number'
	if vel.x < 0:
		vel.x = vel.x * -1
	if vel.y < 0:
			vel.y = vel.y * -1
	if vel.z < 0:
		vel.z = vel.z * -1
	
	var magnitude = sqrt(vel.x + vel.y + vel.z) # find the magnitude of itself
	
	if magnitude > force_to_break:
		self.queue_free() # break if magnitude is large enough
	
	if !sound.is_playing():
		sound.play()

func _ready():
	if ungrabbable:
		self.add_to_group(ungrabbable_group)
