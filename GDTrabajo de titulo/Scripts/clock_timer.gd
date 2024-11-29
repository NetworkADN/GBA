extends Node
class_name Clocktimer



# Called when the node enters the scene tree for the first time.
var timer = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = GlobalTimer.tiempo_restante

func time_to_string() -> String:
	var sec = fmod(timer, 60)
	var min = timer / 60
	var format_string = "%02d : %02d"
	var actual_string = format_string % [min, sec]
	return actual_string
