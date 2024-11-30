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
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_lca  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

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
		await get_tree().create_timer(1).timeout
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
	


func show_next_line():
	# Avanza al siguiente diálogo
	if current_line < dialog.size():
		name_label.bbcode_text = dialog[current_line]  # Nombre del hablante
		dialog_label.bbcode_text = dialog[current_line + 1]  # Texto del diálogo
		current_line += 2  # Avanza al siguiente par (nombre + texto)
	else:
		close_dialog_boxes()
		DialogsFlags.sc_final = true
		DialogsFlags.key = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.sc_final == false and DialogsFlags.sc_puzzle == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
