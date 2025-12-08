extends Control

func _ready() -> void:
	play_menu_music()

func play_coin_sound() -> void:
	$SoundCoin.play()
	await $SoundCoin.finished
	
func play_button_click_sound() -> void:
	$SoundButtonClick.play()
	await $SoundButtonClick.finished
	print("click")

func play_enemy_slime_sound() -> void:
	$SoundSlimeEnemy.play()
	await $SoundSlimeEnemy.finished

	
func play_fall_zone_sound() -> void:
	$SoundFallZone.play()
	await $SoundFallZone.finished
	
	
func play_menu_music() -> void:
	#print("play menu music")
	$MusicMenu.play()
	

func stop_menu_music() -> void:
	#print("stop menu music")
	$MusicMenu.stop()
	
	
	
func play_level_music() -> void:
	#print("play level music")
	$MusicLevel.play()
	

func stop_level_music() -> void:
	#print("stop level music")
	$MusicLevel.stop()
	
