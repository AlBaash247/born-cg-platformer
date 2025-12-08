extends Control

func _ready() -> void:
	SoundManager.stop_level_music()
	SoundManager.play_menu_music()

func _on_btn_main_menu_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://menu_title.tscn")
	
