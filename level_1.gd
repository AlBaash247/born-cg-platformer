extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_level_music()
	GlobalScript.current_level_coins_collected = 0
	GlobalScript.current_level_coins_count = $CoinsContainer.get_child_count()

func get_current_level_coins_count () ->void:
	return $CoinsContainer.get_child_count()
	
