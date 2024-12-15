extends Node2D

@onready var ok = $answer/caja_ok/ok
@onready var back = $answer/caja_atras/back
@onready var summit = $answer/LineEdit
@onready var background = $ParallaxBackground/ParallaxLayer/Pizarra
@onready var problem = $ParallaxBackground/ParallaxLayer/Pizarra/Area2D/CollisionShape2D/Problem
@onready var transition = $ParallaxBackground/ParallaxLayer/Pizarra/Transition
@onready var button = $ParallaxBackground/ParallaxLayer/Pizarra/Button


@onready var TimerC = $TimerC
@onready var obj_label = $Objetivo #Label de objetivo
var next_scene = "" 

var TimerClock = Clocktimer

var game_timer: float = 0.0
var timer_active: bool = false

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
	timer_active = true

func _process(delta):
	if DialogsFlags.escuela == false:
		obj_label.text = "Objetivo: Ir a escuela"
	elif DialogsFlags.m3 == false:
		obj_label.text = "Objetivo: Ir al M3"
	elif DialogsFlags.m3_puzzle == false or DialogsFlags.m3_final == false:
		obj_label.text = "Objetivo: Resolver la ecuación"
	elif DialogsFlags.bibl == false:
		obj_label.text = "Objetivo: Ir a la biblioteca"
	elif DialogsFlags.bibl_puzzle == false or DialogsFlags.bibl_final == false:
		obj_label.text = "Objetivo: Revisa la sala multiuso"
	elif DialogsFlags.lab == false:
		obj_label.text = "Objetivo: Ir al laboratorio"
	elif DialogsFlags.lab_puzzle == false or DialogsFlags.lab_final == false:
		obj_label.text = "Objetivo: Revisar el laboratorio"
	elif DialogsFlags.sc == false:
		obj_label.text = "Objetivo: Ir a la sala de carrera"
	elif DialogsFlags.sc_puzzle == false or DialogsFlags.key == false:
		obj_label.text = "Objetivo: Busca la clave"
	else:
		obj_label.text = "Objetivo: Ir a la oficina en escuela"
	if timer_active == true and DialogsFlags.m3_puzzle == false:
		GlobalCalcs.time_ecu += delta
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
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
