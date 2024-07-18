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
	level = data
	
	ResourceSaver.save(self, save_path)
	print_rich("[rainbow]Game Saved!")
	


func load_game():
	if ResourceLoader.exists(save_path):
		var retrieved_save = ResourceLoader.load(save_path, "")
		level = retrieved_save.level
		return retrieved_save # Returns the resource where everything is held
		
	else:
		return null # If the resource loader fails for some reason, returns null
		
	





# -- This is correctly saving the objects, I mean the RigidBody3D part. 
# -- However, the children do not get saved. So only an inactive RigidBody3D with no mesh or collision shape gets saved.
# -- This is an issue.

func save_player_hub(objects_to_save):
	player_hub_objects = [] # attempt to clear the old saved objects, to avoid accidentally generating another 2.2 MB file
	player_hub_objects = objects_to_save
	
	ResourceSaver.save(self, save_path)
	print_rich("[rainbow]Player Hub Objects have been saved")


func load_player_hub(root_node):
	if ResourceLoader.exists(save_path):
		var retrieved_save = ResourceLoader.load(save_path, "")
		player_hub_objects = retrieved_save.player_hub_objects
		
		for i in player_hub_objects:
			print(i)
			var new_object = i.instantiate()
			root_node.add_child(i)
			new_object.global_position = Vector3(0, 5, 0)
	
	else:
		print("failed to load player hub")








