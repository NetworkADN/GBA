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
@onready var dialog_label = $Dialogo/Dialogo_pc  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	if DialogsFlags.lab_final == false and DialogsFlags.lab_puzzle == true:
		# Inicializa el diálogo
		dialog = [
			think,"¿Eh? cuando he terminado el juego, se ha abierto una nota...",
			note, "Si llegaste hasta aqui es que estas en busqueda de 'la llave'",
			note, "La he escondido en la sala de la carrera de informatica, dentro de un locker con un candado",
			note, "La clave se encuentra en distintos lugares de la universidad, para saber donde buscar consulta el cajón que se encuentra justo al lado del locker",
			note, "Las cosas no son como crees, toda esta busqueda pronto llegará a su fin",
			note, "Pronto sabras la verdad...",
			note, "J.P.A.",
			think, "¿Un locker con candado? la sala de la carrera se encuenbtra en el m8",
			think, "Supongo que debo ir a echar un vistazo...",
			think, "¿Quien es J.P.A. y por que me hace pasar por todo esto por una simple llave?",
			think, "Esto es cada vez mas raro...",
			supplayer1, "Tu siguiente objetivo es ir a la sala de carrera en el m8"
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
		DialogsFlags.lab_puzzle = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.lab_puzzle == true and DialogsFlags.lab_final == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
