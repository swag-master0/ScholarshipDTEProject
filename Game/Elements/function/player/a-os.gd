extends Node3D

@onready var a_os = $"Scene/a-os"
@onready var processing = $Scene/Processing

@onready var face = $Scene/FaceAttachment
@onready var eyes = $Scene/FaceAttachment/Bone/Eyes
@onready var mouth = $Scene/FaceAttachment/Bone/Mouth



func ApplyMood(mood: int):
	# Standard
	if mood == 0:
		a_os.visible = true
		face.visible = true
		eyes.play("idle")
		mouth.play("standard-idle")
		processing.visible = false
	
	# Processing
	if mood == 1:
		a_os.visible = false
		face.visible = false
		processing.visible = true
	
	
	
	

# Mouth Movement
func Yap():
	mouth.play("standard-yap")
	

