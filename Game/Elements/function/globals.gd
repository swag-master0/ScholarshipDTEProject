extends Node

var loading_screen = preload("res://Elements/function/menus/loading_screen.tscn")

var next_scene : String = "res://Elements/environments/misc/main_menu/main_menu.tscn"

var loading_screen_colour = Color(0.0824, 0.0784, 0.1176, 1)
var transparent_colour = Color(0.0824, 0.0784, 0.1176, 0)
var transition_time : float = 0.5

var old_scene


func _enter_tree():
	transition(true)
	old_scene = get_tree().current_scene



func scene_transition():
	transition(false)
	
	await get_tree().create_timer(1).timeout
	
	ResourceLoader.load_threaded_request(next_scene)
	print_rich("[rainbow]", next_scene)




func _process(_delta):
	# track progress of game load
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.next_scene, progress)
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene)
	
	if get_tree().current_scene != old_scene and get_tree().current_scene != null:
		transition(true)
		old_scene = get_tree().current_scene
	

func transition(fade_in : bool):
	if fade_in == true:
		# There's a frame where the 
		var screen = loading_screen.instantiate()
		get_tree().current_scene.add_child(screen)
		
		var image = screen.get_children()[0]
		image.color = loading_screen_colour
		image.visible = true
		
		var tween = get_tree().create_tween()
		tween.tween_property(image, "color", transparent_colour, transition_time)
		await tween.finished
		
		screen.queue_free()
	
	if fade_in == false:
		var screen = loading_screen.instantiate()
		get_tree().current_scene.add_child(screen)
	
		# transition effects
		var image = screen.get_children()[0]
		image.color = transparent_colour
		image.visible = true
		
		var tween = get_tree().create_tween()
		tween.tween_property(image, "color", loading_screen_colour, transition_time)
		await tween.finished
	




