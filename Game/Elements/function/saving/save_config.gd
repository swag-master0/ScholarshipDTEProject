extends Resource
class_name SaveConfig

const save_config_path = "user://config.res"


@export_group("Settings")
@export var SENSITIVITY: float = 0.25
@export var FULLSCREEN: bool = true
@export var VOLUME_MUSIC: float = 50
@export var VOLUME_SFX: float = 50
@export var VOLUME_AMBIENCE: float = 50


var default_sensitivity = 0.25
var default_fullscreen = true
var default_musicvolume = 1
var default_sfxvolume = 1
var default_ambiencevolume = 1




func save_config(sens: float, fullscrn: bool, vMusic: float, vSFX: float, vAmbience: float):
	print_rich("[color=YELLOW]Save System: Saving Settings Config")
	
	SENSITIVITY = sens
	FULLSCREEN = fullscrn
	VOLUME_MUSIC = vMusic
	VOLUME_SFX = vSFX
	VOLUME_AMBIENCE = vAmbience
	
	ResourceSaver.save(self, save_config_path)
	
	print_rich("[color=YELLOW]Save System: Saved Settings Config")


func load_config():
	print_rich("[color=YELLOW]Save System: Retrieving config data")
	
	
	if ResourceLoader.exists(save_config_path):
		var retrieved_save = ResourceLoader.load(save_config_path, "")
		
		SENSITIVITY = retrieved_save.SENSITIVITY
		FULLSCREEN = retrieved_save.FULLSCREEN
		VOLUME_MUSIC = retrieved_save.VOLUME_MUSIC
		VOLUME_SFX = retrieved_save.VOLUME_SFX
		VOLUME_AMBIENCE = retrieved_save.VOLUME_AMBIENCE
		
		print_rich("[color=GREEN]Save System: Loaded Successfully : ", retrieved_save)
		return retrieved_save # Returns the resource where everything is held
		
		
	else:
		print_rich("[color=YELLOW]Save System: No config data found, creating new file with default parameters.")
		save_config(
			default_sensitivity, 
			default_fullscreen, 
			default_musicvolume, 
			default_sfxvolume, 
			default_ambiencevolume
		)
		#load_config()
		#return null # If the resource loader fails for some reason, returns null
		
		var retrieved_save = ResourceLoader.load(save_config_path, "")
		
		SENSITIVITY = retrieved_save.SENSITIVITY
		FULLSCREEN = retrieved_save.FULLSCREEN
		VOLUME_MUSIC = retrieved_save.VOLUME_MUSIC
		VOLUME_SFX = retrieved_save.VOLUME_SFX
		VOLUME_AMBIENCE = retrieved_save.VOLUME_AMBIENCE
		
		print_rich("[color=GREEN]Save System: Loaded Successfully : ", retrieved_save)
		return retrieved_save # Returns the resource where everything is held
		
		
