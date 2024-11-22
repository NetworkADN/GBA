extends Node2D

@onready var transition = $"ParallaxBackground/ParallaxLayer/Biblioteca(mesa)/Transition"
var next_scene = ""

@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_mesa/Dialogo/Dialogo_mesa # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_mesa/nombres/caja_nombre  # Nodo para el texto del nombre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")


func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Biblioteca/Biblioteca(sala_multiuso).tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
