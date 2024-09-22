extends Node3D

@onready var player = $Player
@onready var shock_stinger = $ShockStinger

@onready var bomb_stinger = $BombStinger
@onready var bomb_stinger_2 = $BombStinger2

@onready var bulb = $bomb/Bulb
@onready var light = $bomb/OmniLight3D
@onready var timer = $Timer
@onready var explosion_sound = $Explosion
@onready var explosion_effects = $ExplosionParticles
@onready var explosion_light = $ExplosionEffects

@onready var black = $Black


@export var ending_scene : String = "res://Elements/levels/misc/ending.tscn"

var hasObjective : bool = false


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "up":
		shock_stinger.play()
		
		await get_tree().create_timer(1).timeout
		player.dialogue_queue.append(1)
		player.dialogue_queue.append("i know what it looks like, but bare with me for a sec")
		player.dialogue_queue.append(8)
		player.dialogue_queue.append("i've had to leave it here because i'm scared of it...")
		player.dialogue_queue.append(2)
		player.dialogue_queue.append("i don't know if it's armed, and i fear it could be the end of us")


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		hasObjective = true
		
		player.dialogue_queue.append(8)
		player.dialogue_queue.append("long ago, one of those bombs went off in an act of war")
		player.dialogue_queue.append("little did they know, it was too powerful")
		player.dialogue_queue.append("...")
		player.dialogue_queue.append("it wasn't my fault")


func _on_ending_trigger_body_entered(body):
	if body.is_in_group("player") and hasObjective:
		
		player.dialogue_queue.append(8)
		player.dialogue_queue.append("is that live?")
		player.dialogue_queue.append("uh oh")
		
		
		bomb_stinger.play()
		bomb_stinger_2.play()
		bulb.visible = true
		light.visible = true
		
		timer.start()




func _on_timer_timeout():
	# play an animation
	explosion_sound.play()
	explosion_effects.emitting = true
	explosion_light.visible = true
	
	await get_tree().create_timer(0.5).timeout
	black.visible = true
	explosion_sound.stop()
	
	#await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file(ending_scene)
