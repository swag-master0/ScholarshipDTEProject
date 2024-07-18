extends Resource


const SAVE_GAME_PATH = "user://playerhub.tres"

var saved_objects = []


func savegame():
	ResourceSaver.save(self, SAVE_GAME_PATH)


func loadgame():
	pass


