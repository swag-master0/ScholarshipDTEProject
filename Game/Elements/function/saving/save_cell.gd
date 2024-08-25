extends Resource
class_name SaveCell
# To use this script anywhere, use :
# var save = SaveGame.new()
# ...


const save_playerhub_path = "user://cell.res"
const save_addtoplayerhub_path = "user://cell_add.res"

# Variables are the things you want to save


@export_group("Player Hub Objects")
@export var player_hub_objects : Array = []   # Array of objects, which are turned into PackedScenes to maintain their children's properties
@export var add_new_objects : Array = []





func save_cell(objects_to_save : Array, type_of_save : bool = true):
	print_rich("[color=RED]Save Hub System: Save initialised: ", objects_to_save, ", ", type_of_save)
	
	if !ResourceLoader.exists(save_playerhub_path):
		ResourceSaver.save(self, save_playerhub_path)
	
	if type_of_save and !objects_to_save.is_empty():
		print_rich("[color=ORANGE]Save Hub System: Saving player hub objects : ", objects_to_save)
		#push_warning("Save System: Saving player hub objects")
		
		player_hub_objects = [] # attempt to clear the old saved objects, to avoid accidentally generating another 2.2 MB file
		player_hub_objects = objects_to_save
		
		
		ResourceSaver.save(self, save_playerhub_path)
		
		#push_warning("Save System: Player hub save sucessful!")
		print_rich("[color=GREEN]Save Hub System: Player hub save successful")
	
	elif !type_of_save and !objects_to_save.is_empty(): # adding new objects
		#push_warning("Save System: Importing objects to playerhub")
		print_rich("[color=ORANGE]Save Hub System: Importing new player hub objects : ", objects_to_save)
		
		
		for i in objects_to_save:
			add_new_objects.append(i)
		
		
		ResourceSaver.save(self, save_addtoplayerhub_path)


func load_cell(root_node):
	print_rich("[color=ORANGE]Save Hub System: Loading player hub objects to : ", root_node)
	#push_warning("Save System: Loading player hub objects")
	if ResourceLoader.exists(save_playerhub_path):
		var retrieved_save = ResourceLoader.load(save_playerhub_path, "")
		player_hub_objects = retrieved_save.player_hub_objects
		
		for i in player_hub_objects:
			if i is PackedScene:
				var new_object = i.instantiate()
				root_node.add_child(new_object)
				print_rich("[color=GREY]Loaded Object: ", new_object)
		
		
	
	
	if ResourceLoader.exists(save_addtoplayerhub_path):
		var added_retrieved_save = ResourceLoader.load(save_addtoplayerhub_path, "")
		add_new_objects = added_retrieved_save.add_new_objects
		
		for i in add_new_objects:
			print(i)
			if i is PackedScene:
				var new_object = i.instantiate()
				root_node.add_child(new_object)
				new_object.global_position = Vector3(0, 60, 0)
				print_rich("[color=GREY]Loaded Newly Added Object: ", new_object)
		
		add_new_objects = []
		DirAccess.remove_absolute(save_addtoplayerhub_path)
		#ResourceSaver.save(self, save_addtoplayerhub_path)
	
	
	else:
		#push_error("Save System: Player hub load Failed")
		print_rich("[color=RED]Player Hub Load Failed")
