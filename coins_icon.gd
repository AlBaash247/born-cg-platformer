extends Sprite3D

var coins = 0
var player_name = "robot"
var hearts = 3.5
const ICON_ROTATION_SPEED = 2.5
var is_key_collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("result: " + str(add(7,9)) )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_inputs()
	


func handle_inputs() -> void:
	# 1 degree = 1/360 part of circle
	# 1 radian is the angle made at the center of a circle by an arc ...
	# ... whose length is equal to the radius of the circle
	# rotate uses Radian by default rotate_y(0.05)
	# you can convert degres to radian, using deg_to_rad() function
	# rotate_y(deg_to_rad(ICON_ROTATION_SPEED))
	
	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(-ICON_ROTATION_SPEED))

	elif Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(ICON_ROTATION_SPEED))


func minion() -> void:
	print("meaw")

func add(x,y) -> int:
	return x+y
	

	
