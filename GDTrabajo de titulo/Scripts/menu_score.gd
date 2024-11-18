extends Control

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	next_scene = "res://Scenes/Menus/Menu.tscn"
	get_tree().change_scene_to_file(next_scene)
