extends Node3D

# Maybe rework this into the player script

var loading_screen = preload("res://Elements/function/loading_screen.tscn")
var next_scene : String = "res://Elements/function/main_menu.tscn"

var loading_screen_colour = Color(0.0824, 0.0784, 0.1176, 1)
var transparent_colour = Color(0.0824, 0.0784, 0.1176, 0)
var transition_time : float = 0.5

var old_scene


# Track progress of loading screen
func _process(_delta):
	# track progress of game load
	var progress = []
	ResourceLoader.load_threaded_get_status(LoadingScreen.next_scene, progress)
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene)
	
	if get_tree().current_scene != old_scene and get_tree().current_scene != null:
		transition(true)
		old_scene = get_tree().current_scene
	


# -- Loading Screen Functionality
func _enter_tree():
	transition(true)
	old_scene = get_tree().current_scene
	
	get_tree().paused = false
	Engine.time_scale = 1
	
	


func scene_transition():
	print_rich("[color=PINK]Scene transition... ")
	print("")
	print("")
	transition(false)
	
	await get_tree().create_timer(1).timeout
	
	ResourceLoader.load_threaded_request(next_scene)
	# could potentially include save function here
	#save_game(next_scene)




func transition(fade_out : bool):
	var screen = loading_screen.instantiate()
	get_tree().current_scene.add_child(screen)

	if fade_out == true:
		pass

		# Try using get_node() to try get better outcome, instead of searching for children and playing the animation

		for i in screen.get_child(0).get_children():
			if i is AnimationPlayer:
				i.play("fade_out")
				await i.animation_finished
				screen.queue_free()
		
	
	if fade_out == false:
		pass

		for i in screen.get_child(0).get_children():
			if i is AnimationPlayer:
				i.play("fade_in")
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				await i.animation_finished
				
				get_tree().paused = false
				Engine.time_scale = 1
		
	
