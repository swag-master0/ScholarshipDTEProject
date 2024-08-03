extends Resource
class_name PlayerName


const save_name_path = "user://save_plrname.tres"
@export var name : String = ""


func save_name(new_name: String):
	name = new_name
	ResourceSaver.save(self, save_name_path)


func fetch_name() -> String:
	if ResourceLoader.exists(save_name_path):
		var retrieved_save = ResourceLoader.load(save_name_path, "")
		name = retrieved_save.name
		return retrieved_save.name 
	else:
		return ", i forgot your name, "
