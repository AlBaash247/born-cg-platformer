extends Area3D

# the number of degress the coins rotates every frame
const COIN_ROTATION_SPEED : float = 2

@export var hud : CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_if_coins_container_exist_in_current_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(COIN_ROTATION_SPEED))
	
func check_if_coins_container_exist_in_current_level() -> void:
	# get current level (scene), if null throw error
	var scene := get_tree().get_current_scene()
	assert(scene != null, "get_tree().get_current_scene() return null,
	 maybe script/Node not attached to a scene")

	# in current level (scene) look for node with name CoinsContainer
	# if not found throw error
	assert( scene.get_node_or_null("CoinsContainer") != null,
	 "ERROR, The current level ("+ scene.name + ")
	  doesn't have a container (Node3D) with name CoinsContainer")

func _on_body_entered(body: Node3D) -> void:
	
	GlobalScript.increment_current_level_coins_collected()
	SoundManager.play_coin_sound()
	hud.get_node("CoinsCollectedLabel").text = str(GlobalScript.current_level_coins_collected)

	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	$AnimationPlayer.play("coin_bounce_animation")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#remove coin instance from scene
	queue_free()  
