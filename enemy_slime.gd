extends CharacterBody3D


var speed := 2.5
var turning := false
@export var direction := Vector3(0,0,0)
@export var enable_turn_around_at_edges := true

func _physics_process(delta: float) -> void:
	
	# enemy movment
	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
	if is_on_wall() and not turning:
		turn_around()
	
	if not $RayCast3D.is_colliding() and is_on_floor() and not turning and enable_turn_around_at_edges:
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
	


func _on_enemy_slime_side_checker_body_entered(body: Node3D) -> void:
	SoundManager.play_enemy_slime_sound()
	$EnemySlimeSideChecker.set_collision_mask_value(1,false)
	$EnemySlimeTopChecker.set_collision_mask_value(1,false)
	
	#if player touched an enemy from the side then change the scene!
	get_tree().change_scene_to_file("res://menu_game_over.tscn")

# body represents the node that came into contact with area3d
func _on_enemy_slime_top_checker_body_entered(body: Node3D) -> void:
	$SoundSquash.play()
	$EnemySlimeSideChecker.set_collision_mask_value(1,false)
	$EnemySlimeTopChecker.set_collision_mask_value(1,false)
	
	# if player jumped on top of enemy, play animation "squash"
	# then make charactor jump
	$AnimationPlayer.play("squash")
	body.bounce()

	# stop enemy after being squashed
	direction = Vector3.ZERO
	speed = 0
	
	# wait 1 sec then remove dead enemy
	await get_tree().create_timer(1).timeout
	queue_free()
	
