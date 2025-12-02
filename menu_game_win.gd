extends Control


func _on_btn_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_title.tscn")
