extends CharacterBody3D


const SPEED := 7.0
var turning := false
@export var direction := Vector3(0,0,0)

func _physics_process(delta: float) -> void:
	
	# enemy movment
	velocity.x = SPEED * direction.x
	velocity.z = SPEED * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
	if is_on_wall() and not turning:
		turn_around()
	
	
func turn_around():
	turning = true
	var temp_dir := direction
	direction = Vector3.ZERO
	
	# a tween is used to animate 2 key-frames of animation programtically
	var turn_tween := create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0,180,0), 0.6).as_relative()
	
	# stop the code here and wait for 0.6 seconds, then resume the code excuation after timeout
	await get_tree().create_timer(0.6).timeout
	

	direction.x = temp_dir.x * -1
	direction.z = temp_dir.z * -1
	turning = false
	
