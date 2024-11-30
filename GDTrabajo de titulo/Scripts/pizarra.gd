extends Node2D

@onready var ok = $answer/caja_ok/ok
@onready var back = $answer/caja_atras/back
@onready var summit = $answer/LineEdit
@onready var background = $ParallaxBackground/ParallaxLayer/Pizarra
@onready var problem = $ParallaxBackground/ParallaxLayer/Pizarra/Area2D/CollisionShape2D/Problem
@onready var transition = $ParallaxBackground/ParallaxLayer/Pizarra/Transition
@onready var button = $ParallaxBackground/ParallaxLayer/Pizarra/Button


@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

@export var normal_color: Color = Color(1, 1, 1, 1)    # Color normal
@export var hover_color: Color = Color.WHITE  # Color iluminado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	summit.visible = false
	ok.visible = false
	back.visible = false
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))

func _process(delta):
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/M3/Sala_m3.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_area_2d_mouse_entered() -> void:
	problem.modulate = hover_color


func _on_area_2d_mouse_exited() -> void:
	problem.modulate = normal_color


func _on_problem_pressed() -> void:
	background.self_modulate = Color(1, 1, 1, 0.5)
	problem.visible =false
	summit.visible = true
	ok.visible = true
	back.visible = true
	button.visible = false


func _on_back_pressed() -> void:
	background.self_modulate = Color(1, 1, 1, 1)
	problem.visible = true
	summit.visible = false
	ok.visible = false
	back.visible = false
	button.visible = true


func on_tiempo_terminado():
	next_scene = "res://Scenes/Menus/Menu_score.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
