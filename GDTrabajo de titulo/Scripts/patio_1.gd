extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Patio_1/Transition

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

# Función para el primer botón
func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Entradas/entrada.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el segundo botón
func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/M3/Pasillo_m3.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el tercer botón
func _on_button_3_pressed() -> void:
	next_scene = "res://Scenes/Patios/Patio_casino.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el cuarto botón
func _on_button_4_pressed() -> void:
	next_scene = "res://Scenes/Extras/Diario_mural.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el cambio de escena
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)



	
