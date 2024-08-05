extends Node


var c1_m2_IntroDialogue = [
	""
]



@onready var rail_anims = $"../RailsPlayerHub/AnimationPlayer"
var allow_exit = false


func _ready():
	rail_anims.play("down")

func _process(_delta):
	await get_tree().create_timer(10).timeout
	allow_exit = true



func _on_exit_body_entered(body):
	if body.is_in_group("player") and allow_exit == true:
		rail_anims.play("up")
