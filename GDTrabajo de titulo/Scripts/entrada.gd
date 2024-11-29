extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Entrada/Transition

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music_game()
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	if GlobalTimer.ft == false:
		GlobalTimer.iniciar_temporizador()
		GlobalTimer.ft = true

func _process(delta):
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

# Función para el primer botón
func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Patios/Patio_1.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el segundo botón
func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/Entradas/Escaleras_Lab.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el cambio de escena
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
