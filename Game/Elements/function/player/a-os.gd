extends Node3D

@onready var a_os = $"Scene/a-os"
@onready var mesh = $"Scene/a-os/A-OS/Skeleton3D/Icosphere"
@onready var processing = $Scene/Processing

@onready var face = $Scene/FaceAttachment
@onready var eyes = $Scene/FaceAttachment/Bone/Eyes

@onready var tween = get_tree().create_tween()


func ApplyMood(mood: int):
	# Standard
	if mood == 0:
		a_os.visible = true
		face.visible = true
		eyes.play("idle")
		processing.visible = false
	
	# Processing
	if mood == 1:
		a_os.visible = false
		face.visible = false
		processing.visible = true
	
	# add more moods here


# Mouth Movement
func Yap():
	$"Scene/a-os/A-OS/Skeleton3D/Icosphere/AnimationPlayer".play("yap")
	#var random = randf_range(1, 1.5)
	#print(random)
	#mesh.scale *= Vector3(random, random, random)
	#mesh.scale *= random
	#
	#tween.tween_property(mesh, "scale", Vector3(1, 1, 1), 0.1)
	#var tween = get_tree().create_tween()
	#tween.tween_property(mesh, "scale", Vector3(1, 1, 1), 1)
	#
	#
#func _process(delta):
	#print(mesh.global_transform)
	#mesh.scale.lerp(Vector3(1, 1, 1), 0.5)
	
	
	
