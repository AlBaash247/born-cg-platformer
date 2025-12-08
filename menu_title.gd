extends Control

func _on_btn_play_pressed() -> void:
	SoundManager.stop_menu_music()
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://level_1.tscn")
