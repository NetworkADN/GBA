extends Control

@onready var transition = $Transition

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")


func _on_play_pressed() -> void:
	next_scene = "res://Scenes/Entradas/Porton.tscn"
	transition.play("fade_out")


func _on_score_pressed() -> void:
	next_scene = "res://Scenes/Menus/Menu_score.tscn"
	transition.play("fade_out")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
