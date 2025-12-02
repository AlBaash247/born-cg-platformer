extends Control


func _on_btn_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
