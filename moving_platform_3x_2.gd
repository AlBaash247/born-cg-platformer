extends AnimatableBody3D

@export var point_a := Vector3()
@export var point_b := Vector3()
@export var trip_duration : float = 1.0
@export var pause_time : float = 0.7

var current_tween : Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()


func move() -> void:
	if current_tween and current_tween.is_running():
		current_tween.kill()
		
	current_tween = create_tween().set_loops()
	
	current_tween.tween_property(self, "position", point_a, trip_duration).set_trans(Tween.TRANS_QUAD)
	current_tween.tween_interval(pause_time)
	current_tween.tween_property(self, "position", point_b, trip_duration).set_trans(Tween.TRANS_QUAD)
	current_tween.tween_interval(pause_time)


#func move_OLD() -> void:
	## while true is used to avoide recursive overvflow
	#while(true):
		#var tween := create_tween()
		#tween.tween_property(self, "position", point_b, trip_duration).set_trans(Tween.TRANS_QUAD).set_delay(pause_time)
		#tween.tween_property(self, "position", point_a, trip_duration).set_trans(Tween.TRANS_QUAD).set_delay(pause_time)
		## using tween.finished event instead of timer to ensure that tween anamition is done
		#await tween.finished
		#if tween : 
			#tween.kill()
