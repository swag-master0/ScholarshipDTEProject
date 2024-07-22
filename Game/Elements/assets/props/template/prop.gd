extends RigidBody3D

@export var ungrabbable : bool = false
@onready var sound = $Sound

var ungrabbable_group = "ungrabbable"



func _ready():
	self.sleeping = true
	
	if ungrabbable:
		self.add_to_group(ungrabbable_group)


func _on_body_entered(_body):
	if !sound.is_playing():
		sound.play()


func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
		
