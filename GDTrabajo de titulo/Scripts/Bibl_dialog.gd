extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var guard = "Portero"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_biblioteca  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	if DialogsFlags.bibl == false and DialogsFlags.m3_puzzle == true:
		# Inicializa el diálogo
		dialog = [
			think, "Bueno, llegue a la biblioteca",
			player1, "¡Hola! vengo me envió...",
			guard, "¡Hola!, si ya me dijo el profesor que vendrias, la sala esta abierta",
			think, "¿El profesor ya habia dicho que iba a venir?",
			player1, "Okay... Muchas gracias",
			think, "Eso fue raro... ¿Acaso el profesor ya sabia que yo resolvería el problema e iria por la llave?",
			think, "Mejor lo dejo por ahora, ire a la sala multiuso, debería estar recto por aquí...",
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
		DialogsFlags.bibl = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.bibl == false and DialogsFlags.m3_puzzle == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
