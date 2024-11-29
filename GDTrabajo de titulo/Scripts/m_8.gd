extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/M8/Transition

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")

func _process(delta):
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Extras/UTEM.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/M8/Sala_carrera.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
