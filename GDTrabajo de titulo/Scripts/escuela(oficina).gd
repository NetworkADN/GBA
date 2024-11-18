extends Node2D

@onready var transition = $Transition

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")


func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Escuela/Escuela(entrada).tscn"
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
