extends Resource
class_name SaveGame

const save_path = "user://save.tres"

# Variables are the things you want to save
@export var level : String   # must be a string of the file path to go to, default level initially
@export var player_hub_objects : Array   # will be an array of objects, hopefully their positions and properties are stored



# For documentation, see FileAccess(), and ResourceLoader/ResourceSaver

# For saving the game level
func save_game_level(data : String):
	# Saves the script itself, with the variables in it
	push_warning("Save System: Saving game save data")
	
	level = data
	
	ResourceSaver.save(self, save_path)
	
	push_warning("Save System: Game save successful!")
	


func load_game():
	push_warning("Save System: Retrieving Game Save Data")
	
	if ResourceLoader.exists(save_path):
		var retrieved_save = ResourceLoader.load(save_path, "")
		level = retrieved_save.level
		return retrieved_save # Returns the resource where everything is held
		
	else:
		return null # If the resource loader fails for some reason, returns null
		
	




func save_player_hub(objects_to_save):
	push_warning("Save System: Saving Player Hub Objects")
	
	player_hub_objects = [] # attempt to clear the old saved objects, to avoid accidentally generating another 2.2 MB file
	player_hub_objects = objects_to_save
	
	ResourceSaver.save(self, save_path)
	
	push_warning("Save System: Player Hub save sucessful!")


func load_player_hub(root_node):
	push_warning("Save System: Loading Player Hub Objects")
	if ResourceLoader.exists(save_path):
		var retrieved_save = ResourceLoader.load(save_path, "")
		player_hub_objects = retrieved_save.player_hub_objects
		
		for i in player_hub_objects:
			if i is PackedScene:
				var new_object = i.instantiate()
				root_node.add_child(new_object)
	
	
	else:
		push_error("Save System: Player Hub Load Failed")








