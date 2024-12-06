extends Control

# Variables
var player1 = "Yo"
var think = "Idea"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_samu  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrows = $"../Flechas"

func _ready():
	if DialogsFlags.samu == false and DialogsFlags.bibl == true:
		# Inicializa el diálogo
		dialog = [
			think, "Bueno, esta es la sala multiuso...",
			think, "¿Eh? hay una caja muy extraña en la mesa, parece algun tipo de puzle",
			think, "¿Estará la llave dentro?",
			think, "Esto esta demasiado extraño...",
		]
		await get_tree().create_timer(0.5).timeout
		arrows.visible = false
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
		DialogsFlags.samu = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrows.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.samu == false and DialogsFlags.bibl == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
