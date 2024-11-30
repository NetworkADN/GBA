extends Control

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Competencia 1: ", GlobalCalcs.com1_score)
	print("Competencia 2: ", GlobalCalcs.com2_score)
	print("Competencia 3: ", GlobalCalcs.com3_score)
	print("Competencia 4: ", GlobalCalcs.com4_score)


func _on_back_pressed() -> void:
	next_scene = "res://Scenes/Menus/Menu.tscn"
	get_tree().change_scene_to_file(next_scene)
