extends Node2D


@onready var transition = $Transition

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

var game_timer: float = 0.0
var timer_active: bool = false

var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))
	timer_active = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_active:
		game_timer += delta
	if DialogsFlags.t1 == true and DialogsFlags.t2 == true and DialogsFlags.t3 == true and DialogsFlags.t4 == true and DialogsFlags.rec == true and DialogsFlags.cuad1 == true and DialogsFlags.cuad2 == true and DialogsFlags.trap == true:
		end = true
		game_timer = false
	if end == true:
		DialogsFlags.bibl_puzzle = true
		GlobalCalcs.time_box = game_timer
		next_scene = "res://Scenes/Biblioteca/Biblioteca(mesa).tscn"
		transition.play("fade_out")
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()


func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name):
	if end == true:
		get_tree().change_scene_to_file(next_scene)
