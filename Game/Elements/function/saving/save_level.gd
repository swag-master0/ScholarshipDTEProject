extends Resource
class_name SaveGame
# To use this script anywhere, use :
# var save = SaveGame.new()
# ...


const save_progression_path = "user://save.tres"

# Variables are the things you want to save

@export_group("Current Level")
@export var level : String   # must be a string of the file path to go to, default level initially



func save_game(data : String):
	# Saves the script itself, with the variables in it
	print_rich("[color=YELLOW]Save System: Saving game save data : ", data)
	
	level = data
	
	ResourceSaver.save(self, save_progression_path)
	
	#push_warning("Save System: Game save successful!")
	print_rich("[color=YELLOW]Save System: Game save successful!")
	



func load_game():
	#push_warning("Save System: Retrieving Game Save Data")
	print_rich("[color=YELLOW]Save System: Retrieving game save data")
	
	
	if ResourceLoader.exists(save_progression_path):
		var retrieved_save = ResourceLoader.load(save_progression_path, "")
		level = retrieved_save.level
		print_rich("[color=GREEN]Save System: Loaded Successfully : ", retrieved_save)
		return retrieved_save # Returns the resource where everything is held
		
		
	else:
		return null # If the resource loader fails for some reason, returns null
		
	
