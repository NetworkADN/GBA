extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Lab/Transition
@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_lab/Dialogo/Dialogo_lab # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_lab/nombres/caja_nombre  # Nodo para el texto del nombre
@onready var sprite = $ParallaxBackground/ParallaxLayer/Lab/Area2D/Sprite2D
@onready var area2d = $ParallaxBackground/ParallaxLayer/Lab/Area2D

@export var normal_color: Color = Color(1, 1, 1, 1)    # Color normal
@export var hover_color: Color = Color.RED #Color iluminado

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DialogsFlags.lab_puzzle == true:
		sprite.visible = false
		area2d.visible = false
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Labs/Pasillo_Labs.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			next_scene = "res://Scenes/Labs/PC.tscn"
			transition.play("fade_out")
			AudioManager.steps_audio.play()


func _on_area_2d_mouse_entered() -> void:
	sprite.modulate = hover_color


func _on_area_2d_mouse_exited() -> void:
	sprite.modulate = normal_color


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
