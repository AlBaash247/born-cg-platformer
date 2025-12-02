extends CharacterBody3D


const SPEED : float = 9.0
const JUMP_VELOCITY : int = 12

var xform : Transform3D



func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	handle_palyer_movment()
	
	# make CameraController Match the position of the player
	$CameraController.position = lerp($CameraController.position, position, 0.16)
	
	
func handle_palyer_movment() -> void:
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Player Character animation:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")
		
	# rotate camera left
	if Input.is_action_just_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(-30))
	
	# rotate camera right
	if Input.is_action_just_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(30))
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	# make player character move in relation of camera rotaiton
	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	$RayCast3D.position = global_position
	
	# rotate carachter in relation to the camera
	if input_dir != Vector2.ZERO:
		$Armature.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
		
	# rotate player character to match floor
	if is_on_floor():
		match_floor_rotation($RayCast3D.get_collision_normal())
	else:
		match_floor_rotation(Vector3.UP)
	
	# player character movement
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func match_floor_rotation(floor_normal : Vector3):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	
	#match floor rotation smoothly
	global_transform = global_transform.interpolate_with(xform, 0.3)
	

func bounce () -> void:
	# Handle jump.
		velocity.y = JUMP_VELOCITY

func _on_fall_zone_body_entered(body: Node3D) -> void:
	#reset game if player fall off
	get_tree().change_scene_to_file("res://menu_game_over.tscn")
