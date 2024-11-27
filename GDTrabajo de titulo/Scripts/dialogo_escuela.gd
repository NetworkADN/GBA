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
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $escuela/Dialogo_escuela  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

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
		DialogsFlags.escuela = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.escuela == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
