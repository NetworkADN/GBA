extends Control

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_play_pressed() -> void:
	next_scene = "res://Scenes/Entradas/Porton.tscn"
	get_tree().change_scene_to_file(next_scene)


func _on_score_pressed() -> void:
	next_scene = "res://Scenes/Menus/Menu_score.tscn"
	get_tree().change_scene_to_file(next_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
