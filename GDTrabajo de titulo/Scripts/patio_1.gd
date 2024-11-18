extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Patio_1/Transition

var next_scene = "" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")

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



	
