extends RigidBody3D

@export var ungrabbable : bool = false
@export var force_for_sound : float = 2.5

var ungrabbable_group = "ungrabbable"


func _ready():
	sleeping = true
	
	#set_collision_layer_value(2, true)
	#set_collision_layer_value(1, false)
	
	
	if ungrabbable:
		add_to_group(ungrabbable_group)

func _on_body_entered(_body):
	var vel = abs(self.get_linear_velocity())
	var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
	
	if magnitude > force_for_sound:
		# the worlds most dumbest way to do this
		for i in get_children():
			if i is AudioStreamPlayer3D:
				
				i.volume_db = linear_to_db(0.1)
				i.bus = "sfx"
				i.pitch_scale = (randf_range(0.75, 2.5) * (15 / self.mass))
				i.play()

func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
