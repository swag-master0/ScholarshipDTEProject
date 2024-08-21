extends Node3D

@onready var a_os = $"Scene/a-os"
@onready var mesh = $"Scene/a-os/A-OS/Skeleton3D/Icosphere"
@onready var processing = $Scene/Processing

@onready var face = $Scene/FaceAttachment

@onready var eye_pos = $Scene/FaceAttachment/Bone/EyePos
@onready var eye_left = $Scene/FaceAttachment/Bone/EyePos/EyeLeft
@onready var eye_right = $Scene/FaceAttachment/Bone/EyePos/EyeRight
@onready var initial_position = eye_pos.position
var eye_pos_offset : Vector3
var eye_rot_offset : float #only affects z rotation


func ApplyMood(mood: int):
	# Processing
	if mood == 0:
		a_os.visible = false
		face.visible = false
		processing.visible = true
	
	# Normal
	if mood == 1:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0, 0)
		eye_rot_offset = 0
		
		eye_left.play("idle")
		eye_right.play("idle")
		
		processing.visible = false
	
	# Sorrow
	if mood == 2:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0, 0)
		eye_rot_offset = 0
		
		eye_left.play("sorrow")
		eye_right.play("sorrow")
		
		processing.visible = false
	
	# Angry
	if mood == 3:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0, 0)
		eye_rot_offset = 0
		
		eye_left.play("anger")
		eye_right.play("anger")
		
		processing.visible = false
	
	# Wink
	if mood == 4:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0, 0)
		eye_rot_offset = 0
		
		eye_left.play("closed")
		eye_right.play("idle")
		
		processing.visible = false
	
	# Very Happy
	if mood == 5:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0.1, 0)
		eye_rot_offset = 0
		
		eye_left.play("closed_happy")
		eye_right.play("closed_happy")
		
		processing.visible = false
	
	# Odd
	if mood == 6:
		a_os.visible = true
		face.visible = true
		
		eye_pos_offset = Vector3(0, 0, 0)
		eye_rot_offset = 25
		
		eye_left.play("anger")
		eye_right.play("sorrow")
		
		processing.visible = false
	


func _process(_delta):
	eye_pos.position = initial_position + eye_pos_offset
	eye_pos.rotation.z = deg_to_rad(eye_rot_offset)


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
