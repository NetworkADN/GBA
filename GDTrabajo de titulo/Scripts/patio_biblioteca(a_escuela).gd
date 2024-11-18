extends Node2D

@onready var transition = $"ParallaxBackground/ParallaxLayer/Patio_Biblioteca(a escuela)/Transition"

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")


func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Patios/Patio_casino.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/Escuela/Pasillo_a_escuela.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

func _on_button_3_pressed() -> void:
	next_scene = "res://Scenes/Patios/Patio_Biblioteca(a biblioteca).tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
