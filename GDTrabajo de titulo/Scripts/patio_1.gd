extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Patio_1/Transition

@onready var TimerC = $TimerC
@onready var obj_label = $Objetivo #Label de objetivo
var next_scene = "" 

var TimerClock = Clocktimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))

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

func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")

# Función para el cambio de escena
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)



	
