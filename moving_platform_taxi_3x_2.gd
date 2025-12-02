extends AnimatableBody3D

@export var points := PackedVector3Array()
@export var trip_durations: Array[float] = []
## Array of floats, one for each position in points. Must match points array size.
## If trip_durations is shorter than points, remaining points will use the last duration.
## If trip_durations is empty, all points will use a default duration of 1.0 seconds.
@export var pause_times: Array[float] = []
## Array of floats, one for each waypoint. The platform will pause for this duration after reaching each waypoint.
## If pause_times is shorter than points, remaining waypoints will use the last pause time.
## If pause_times is empty, all waypoints will use a default pause time of 0.0 seconds.

var is_moving := false


func move() -> void:
	is_moving = true
	# while true is used to avoide recursive overvflow
	for i in range(points.size()):
		var p: Vector3 = points[i]
		var duration: float = 1.0
		if trip_durations.size() > 0:
			if i < trip_durations.size():
				duration = trip_durations[i]
			else:
				duration = trip_durations[-1]  # Use last duration for remaining points
		
		var tween := create_tween()
		tween.tween_property(self, "position", p, duration).set_delay(0)
		# using tween.finished event instead of timer to ensure that tween anamition is done
		await tween.finished
		if tween : 
			tween.kill()
		
		# Pause at waypoint (before moving to next one)
		var pause_duration: float = 0.0
		if pause_times.size() > 0:
			if i < pause_times.size():
				pause_duration = pause_times[i]
			else:
				pause_duration = pause_times[-1]  # Use last pause time for remaining waypoints
		
		if pause_duration > 0.0:
			await get_tree().create_timer(pause_duration).timeout
	is_moving = false

#func move_back() -> void:
	#is_moving = true
	#
	#var reversed := PackedVector3Array()
	#for i in range(points.size() - 1, -1, -1):
		#reversed.append(points[i])
#
	#for p in reversed:
		#var tween := create_tween()
		#tween.tween_property(self, "position", p, trip_duration).set_delay(0)
		## using tween.finished event instead of timer to ensure that tween anamition is done
		#await tween.finished
		#if tween : 
			#tween.kill()
		#
	#is_moving = false
	#


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not is_moving :
		move()


#func _on_area_3d_body_exited(body: Node3D) -> void:
	#if not is_moving :
		#await get_tree().create_timer(pause_time).timeout
		#move_back()
