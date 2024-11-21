extends Control
# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var student = "Alumno"
var think = "Idea"
var prof = "Profesor"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $m3/Dialogo_m3  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	if DialogsFlags.m3 == false and DialogsFlags.escuela == true:
		# Inicializa el diálogo
		dialog = [
			think, "Bueno, esta es la sala",
			think, "Parece que no esta el profesor aca...",
			player1, "¡Hola! ¿Alguien sabe donde esta el profesor?",
			player1, "Vengo a buscar la llave de una sala",
			student, "Se fue hace un momento, dijo que volvería cuando alguien lograra resolver lo que esta en la pizarra",
			think, "¿Lo que esta en la pizarra?",
			player1, "Okay, muchas gracias",
			think, "Supongo que tendre que esperar a que vuelva o resolver el problema yo mismo...",
			think, "Aunque por el tiempo que me queda, no tengo opción...",
		]
		await get_tree().create_timer(1).timeout
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
	
	if DialogsFlags.m3 == true and DialogsFlags.m3_puzzle == true:
		# Inicializa el diálogo
		dialog = [
			think, "Bueno, creo que lo resolví",
			prof, "¡Hola! parece que alguien logro resolver el problema de la pizarra",
			player1, "Hola profesor, si, fuí yo, vengo a buscar una llave desde escuela",
			prof, "Ah la llave, si, creo que la tengo por aca en algun lado...",
			think, "Por favor, no me diga que no la tiene...",
			prof, "Oh... creo que la he olvidado en la biblioteca, por que no vas por ella muchacho, deberia estar en la sala multiuso",
			think, "y yo que creía que llegaria a tiempo...",
			player1, "Esta bien profesor, muchas gracias de todos modos",
			prof, "Dile al portero de la biblioteca que te he mandado yo, asi te abre la sala",
			supplayer1, "Tu siguiente objetivo es ir a la biblioteca"
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
		DialogsFlags.m3 = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

	
	# Aquí puedes agregar lógica para iniciar un temporizador o la siguiente fase del juego
	##start_timer()

func _input(event):
	# Detecta clic izquierdo o presionar una tecla para avanzar
	if DialogsFlags.escuela == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()

##func start_timer():
	# Lógica para iniciar un temporizador (opcional)
##	print("El tiempo comienza a correr.")
