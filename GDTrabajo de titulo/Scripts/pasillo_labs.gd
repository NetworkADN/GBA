extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Pasillo_Labs/Transition

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Labs/Lab_de_info.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

func _on_button_2_pressed() -> void:
	next_scene = "res://Scenes/Labs/Entrada_Labs.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
