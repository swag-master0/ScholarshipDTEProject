extends RigidBody3D

@export var ungrabbable : bool = false
@export var force_for_sound : float = 1.5

var ungrabbable_group = "ungrabbable"


# 0
var generic_sounds = [
	"res://Art/audio/impact/thump-1.wav",
	"res://Art/audio/impact/thump-2.wav",
	"res://Art/audio/impact/thump-3.wav",
	"res://Art/audio/impact/thump-4.wav"
]

# 1
var wood_sounds = [
	"res://Art/audio/impact/clatter-wood-1.wav",
	"res://Art/audio/impact/clatter-wood-3.wav"
]

# 2
var metal_sounds = [
	"res://Art/audio/impact/clang-metallic-1.wav",
	"res://Art/audio/impact/clang-metallic-2.wav"
]

# 3
var glass_sounds = [
	"res://Art/audio/impact/chink_01.wav",
	"res://Art/audio/impact/chink_02.wav",
	"res://Art/audio/impact/chink_03.wav",
	"res://Art/audio/impact/chink_04.wav"
]


@onready var sound = $Sound



func _ready():
	self.sleeping = true
	
	if ungrabbable:
		self.add_to_group(ungrabbable_group)


func _on_body_entered(_body):
	if (abs(self.linear_velocity.x) > force_for_sound) or (abs(self.linear_velocity.y) > force_for_sound) or (abs(self.linear_velocity.z) > force_for_sound):
		var selected_sound = randi_range(0, sound.get_children().size() - 1)
		sound.get_children()[selected_sound].play()
		print(selected_sound)
		print(sound.get_children()[selected_sound])
	
	#if !sound.is_playing():
		
		
		
	#	if material == 0:
	#		sound.stream = generic_sounds[0]
		
	#	sound.play()


func _process(_delta):
	if self.position.y < -500:
		self.queue_free()
		
