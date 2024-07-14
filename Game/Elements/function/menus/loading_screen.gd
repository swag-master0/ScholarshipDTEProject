extends CanvasLayer

@onready var image = $Image


var loading_screen_colour = Color(0.0824, 0.0784, 0.1176, 1)
var transparent_colour = Color(0.0824, 0.0784, 0.1176, 0)
var transition_time : float = 0.5




"""
func load_scene():
	image.color = transparent_colour
	
	image.visible = true
	print(image.color)
	image.color
	
	var tween = get_tree().create_tween()
	tween.tween_property(image, "color", loading_screen_colour, transition_time)
	await tween.finished
	
	ResourceLoader.load_threaded_request(Globals.next_scene)
	print_rich("[rainbow]", Globals.next_scene)
	

func _process(delta):
	# track progress of game load
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.next_scene, progress)
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(Globals.next_scene)
		get_tree().change_scene_to_packed(packed_scene)
		

"""

