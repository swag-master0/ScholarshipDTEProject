extends Resource
class_name SaveGame
# To use this script anywhere, use :
# var save = SaveGame.new()
# ...


const save_progression_path = "user://save_progression.tres"
const save_playerhub_path = "user://save_playerhub.tres"

# Variables are the things you want to save

@export_group("Current Level")
@export var level : String   # must be a string of the file path to go to, default level initially


@export_group("Player Hub Objects")
@export var player_hub_objects : Array = []   # Array of objects, which are turned into PackedScenes to maintain their children's properties



func save_game_level(data : String):
	# Saves the script itself, with the variables in it
	push_warning("Save System: Saving game save data")
	
	level = data
	
	
	ResourceSaver.save(self, save_progression_path)
	
	push_warning("Save System: Game save successful!")
	


func load_game():
	push_warning("Save System: Retrieving Game Save Data")
	
	if ResourceLoader.exists(save_progression_path):
		var retrieved_save = ResourceLoader.load(save_progression_path, "")
		level = retrieved_save.level
		return retrieved_save # Returns the resource where everything is held
		
	else:
		return null # If the resource loader fails for some reason, returns null
		
	



# -- Save Player Hub is overwriting the level save, and replacing it with an empty string
# -- * Fixed by splitting the progression and playerhub into 2 different save files

func save_player_hub(objects_to_save, type_of_save : bool = true):
	
	if type_of_save:
		push_warning("Save System: Saving player hub objects")
		
		player_hub_objects = [] # attempt to clear the old saved objects, to avoid accidentally generating another 2.2 MB file
		player_hub_objects = objects_to_save
		
		
		ResourceSaver.save(self, save_playerhub_path)
		
		push_warning("Save System: Player hub save sucessful!")
	
	else: # adding new objects
		push_warning("Save System: Importing objects to playerhub")
		
		for i in objects_to_save:
			player_hub_objects.append(i)
		
		
		ResourceSaver.save(self, save_playerhub_path)


func load_player_hub(root_node):
	push_warning("Save System: Loading player hub objects")
	if ResourceLoader.exists(save_playerhub_path):
		var retrieved_save = ResourceLoader.load(save_playerhub_path, "")
		player_hub_objects = retrieved_save.player_hub_objects
		
		for i in player_hub_objects:
			if i is PackedScene:
				var new_object = i.instantiate()
				root_node.add_child(new_object)
	
	
	else:
		push_error("Save System: Player hub load Ffiled")









