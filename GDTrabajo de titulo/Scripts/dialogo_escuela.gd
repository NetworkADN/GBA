extends Control
# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var sec = "Secretaria"
var think = "Idea"
var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $escuela/Dialogo_escuela  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrows = $"../Flechas"

func _ready():
	if DialogsFlags.escuela == false:
		# Inicializa el diálogo
		dialog = [
			think, "Finalmente he llegado a la escuela",
			player1, "¡Buenos Dias!",
			player1, "Hablé por telefono hace unos minutos, vengo a buscar la llave de la sala para poder hacer la ayudantía",
			sec, "¡Hola, buenos dias!",
			sec, "Si lo recuerdo, pero hay un problema, el ultimo profesor que ocupó la llave aun no la devuelve",
			sec, "¿Me harías un favor?",
			player1, "¡Si, porsupuesto!",
			sec, "¿Por qué no vas y se la pides tu mismo?",
			sec, "Debería estar en la segunda sala del segundo piso en el M3",
			player1, "Muchas Gracias, ire enseguida"
		]
		await get_tree().create_timer(0.5).timeout
		arrows.visible = false
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
		if name_label.text == think:
			dialog_box_sprite.modulate = DialogsFlags.think_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulatet
			name_box_sprite.modulate = DialogsFlags.think_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulatet
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
		DialogsFlags.escuela = true


func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	arrows.visible = true

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.escuela == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
