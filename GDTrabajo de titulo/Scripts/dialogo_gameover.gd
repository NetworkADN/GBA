extends Control
# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"

var next_scene = ""

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo
var end = false

# Referencias a nodos
@onready var transition = $"../ParallaxBackground/ParallaxLayer/Transition"
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $gameover/Dialogo_gameover  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	# Inicializa el diálogo
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	dialog = [
		player1, "¡Oh no! se acabó el tiempo y aun no tengo la lave de la sala...",
		supplayer1, "El tiempo se acabó, ahora se te enviará a la pantalla de puntuación para ver que tal lo hiciste",
	]
	await get_tree().create_timer(1).timeout
	dialog_box.visible = true
	name_box.visible = true
	dialog_label.visible = true
	name_label.visible = true
	
	name_label.bbcode_text = player1
	dialog_label.bbcode_text = "..."
	
	if name_label.text == player1:
			dialog_box_sprite.modulate = DialogsFlags.player_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulate1
			name_box_sprite.modulate = DialogsFlags.player_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulate1


func show_next_line():
	# Avanza al siguiente diálogo
	if current_line < dialog.size():
		name_label.bbcode_text = dialog[current_line]  # Nombre del hablante
		dialog_label.bbcode_text = dialog[current_line + 1]  # Texto del diálogo
		if name_label.text == player1:
			dialog_box_sprite.modulate = DialogsFlags.player_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulate1
			name_box_sprite.modulate = DialogsFlags.player_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulate1
		if name_label.text == DialogsFlags.guard or name_label.text == DialogsFlags.sec or name_label.text == DialogsFlags.sec or name_label.text == DialogsFlags.note or name_label.text == DialogsFlags.vic or name_label.text == DialogsFlags.student or name_label.text == DialogsFlags.obt:
			dialog_box_sprite.modulate = DialogsFlags.sec_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulates
			name_box_sprite.modulate = DialogsFlags.sec_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulates
		if name_label.text == supplayer1:
			dialog_box_sprite.modulate = DialogsFlags.obj_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulateo
			name_box_sprite.modulate = DialogsFlags.obj_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulateo
		current_line += 2  # Avanza al siguiente par (nombre + texto)
	else:
		close_dialog_boxes()
		end = true
		next_scene = "res://Scenes/Menus/Menu_score.tscn"
		transition.play("fade_out")

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false

func _input(event):
	# Detecta presionar una tecla para avanzar
	if event.is_action_pressed("ui_accept"):
		show_next_line()

func _on_transition_animation_finished(anim_name: StringName) -> void:
	if  end == true: 
		get_tree().change_scene_to_file(next_scene)
