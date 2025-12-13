extends Node

var current_level_coins_count := 0
var current_level_coins_collected := 0


func increment_current_level_coins_collected():
	# if player collected a coin, increase coins_count
	current_level_coins_collected += 1
	# print(current_level_coins_collected , current_level_coins_count)
	# if player collected all coins in this level the switch to the next level
	if current_level_coins_collected == current_level_coins_count :
		get_tree().change_scene_to_file("res://menu_game_win.tscn")
