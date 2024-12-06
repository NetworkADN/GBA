extends Control
# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var note = "Nota"
var think = "Idea"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_mesa  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Biblioteca(mesa)/Button"

func _ready():
	if DialogsFlags.samu == true and DialogsFlags.bibl_puzzle == true:
		# Inicializa el diálogo
		dialog = [
			think, "Creo que escuche la caja abrirse",
			think, "Dentro hay una nota...",
			note, "He encontrado la llave que estaba dentro de la caja y la he escondido",
			note, "Si la necesitas, la clave para encontrarla se encuentra en el laboratorio de informatica",
			note, "Hay un pc con un juego abierto, terminalo y te dira donde esta escondida.",
			note, "Atentamente, J.P.A.",
			think, "¿Eh? ¿El laboratorio de informatica? ¿Un PC con un juego? y ¿Quien es J.P.A.?",
			think, "Pareciera que estoy en alguna especie de juego...",
			supplayer1, "Tu siguiente objetivo es ir al cuarto piso del m1, al laboratorio de informatica."
		]
		await get_tree().create_timer(1).timeout
		arrow.visible = false
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
		DialogsFlags.bibl_final = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrow.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	if DialogsFlags.samu == true and DialogsFlags.bibl_puzzle == true and DialogsFlags.bibl_final == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
