extends Control

@onready var sound_hover = $Audio/UIHover1
@onready var sound_select = $Audio/UISelect

func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(str(meta))


func _on_button_pressed():
	sound_select.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_button_mouse_entered():
	sound_hover.play()
