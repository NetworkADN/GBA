extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Entrada/Transition

var next_scene = "" 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music_game()
	transition.play("fade_in")

# Función para el primer botón
func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Patios/Patio_1.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Función para el segundo botón
func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/Entradas/Escaleras_Lab.tscn"
	transition.play("fade_out")

# Función para el cambio de escena
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
