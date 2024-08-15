extends RigidBody3D

@export var ungrabbable : bool = false
@export var force_for_sound : float = 1.5

var ungrabbable_group = "ungrabbable"

@onready var sound = $Sound


func _ready():
	self.sleeping = true
	
	if ungrabbable:
		self.add_to_group(ungrabbable_group)
	


func _on_body_entered(_body):
	var vel = abs(self.get_linear_velocity())
	
	var magnitude = sqrt(vel.x + vel.y + vel.z) # calculate magnitude of the force
	
	if magnitude > force_for_sound:
		
		var selected_sound = randi_range(0, sound.get_children().size() - 1)
		if sound.get_children()[selected_sound] is AudioStreamPlayer3D:
			var audio = sound.get_children()[selected_sound]
			
			#audio.volume_db = clamp(linear_to_db(magnitude), 0, 5) 
			audio.volume_db = linear_to_db(0.1)
			audio.bus = "sfx"
			audio.pitch_scale = (15 / self.mass)
			audio.play()
		
	


func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
		
