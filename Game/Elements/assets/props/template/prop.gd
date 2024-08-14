extends RigidBody3D

@export var ungrabbable : bool = false
@export var force_for_sound : float = 0.2

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
		print_rich("[rainbow]prop sound triggered")
		
		var selected_sound = randi_range(0, sound.get_children().size() - 1)
		if sound.get_children()[selected_sound] is AudioStreamPlayer3D:
			var audio = sound.get_children()[selected_sound]
			
			audio.volume_db = clamp(linear_to_db(magnitude), 0, 5) 
			audio.pitch_scale = (15 / self.mass)
			audio.play()
		
		print_rich("[rainbow]", sound.get_children()[selected_sound])
	


func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
		
