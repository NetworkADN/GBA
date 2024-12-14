extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var note = "Nota"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos

@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_lca  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Sala_carrera(locker_abierto)/Button"

func _ready():
	if DialogsFlags.sc_final == false and DialogsFlags.sc_puzzle == true:
		# Inicializa el diálogo
		dialog = [
			think,"¡La llave! ¡Esta aquí dentro! ¡Finalmente!",
			think,"Un momento... Esta llave tiene una etiqueta...",
			think,"Dice 'Victor', ¿se referira a que es la llave del profesor Victor?",
			think,"Será mejor que vaya a la oficina que esta en escuela y preguntar si es su llave...",
			supplayer1, "Tu objetivo final es llevar la llave a la oficina en escuela"
		]
		await get_tree().create_timer(0.5).timeout
		arrow.visible = false
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
		DialogsFlags.sc_final = true
		DialogsFlags.key = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrow.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.sc_final == false and DialogsFlags.sc_puzzle == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
