extends Node3D

@onready var a_os = $"Scene/a-os"
@onready var processing = $Scene/Processing



func ApplyMood(mood: int):
	# Standard
	if mood == 0:
		a_os.visible = true
		processing.visible = false
	
	# Processing
	if mood == 1:
		a_os.visible = false
		processing.visible = true



