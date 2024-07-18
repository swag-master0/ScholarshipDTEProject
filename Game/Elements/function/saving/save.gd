extends Resource
class_name SaveGame

const save_path = "user://save_game.tres"
const cell_save_path = "user://cell_save.tres"

# Variables are the things you want to save
@export var level : String = "res://Elements/environments/chapter1/c1_m1.tscn"   # must be a string of the file path to go to, default level initially
@export var player_hub_objects : Array   # will be an array of objects, hopefully their positions and properties are stored



# For documentation, see FileAccess(), and ResourceLoader/ResourceSaver

func save_game_level(data : String):
	# Saves the script itself, with the variables in it
	level = data
	
	ResourceSaver.save(self, save_path)
	print_rich("[rainbow]Game Saved!")
	
	#load_game()
	


func load_game():
	if ResourceLoader.exists(save_path):
		var retrieved_save = ResourceLoader.load(save_path, "")
		level = retrieved_save.level
		return retrieved_save # Returns the resource where everything is held
		
	else:
		return null # If the resource loader fails for some reason, returns null
		
	




func save_player_hub(root_node):
	pass

func load_player_hub():
	pass


