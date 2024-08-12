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
	if (abs(self.linear_velocity.x) > force_for_sound) or (abs(self.linear_velocity.y) > force_for_sound) or (abs(self.linear_velocity.z) > force_for_sound):
		var selected_sound = randi_range(0, sound.get_children().size() - 1)
		sound.get_children()[selected_sound].play()
	#	print(selected_sound)
	#	print(sound.get_children()[selected_sound])
	


func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
		
