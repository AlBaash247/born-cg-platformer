extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get CoinsContainer from scene tree and assign its child_count to $CoinsCountLabel.text
	var coins_container = get_tree().get_current_scene().get_node_or_null("CoinsContainer")
	assert(coins_container != null, "ERROR, The current level 
	doesn't have a container (Node3D) with name CoinsContainer")
	
	$CoinsCountLabel.text = str(coins_container.get_child_count())
	
	$CoinsCollectedLabel.text = "0"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
