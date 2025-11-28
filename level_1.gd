extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalScript.current_level_coins_count = $CoinsContainer.get_child_count()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
