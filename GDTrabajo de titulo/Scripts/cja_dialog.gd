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
@onready var dialog_label = $Dialogo/Dialogo_cja  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Sala_carrera(cajonera_abierta)/Button"

func _ready():
	if DialogsFlags.cjrepeat == false and DialogsFlags.cj == true:
		# Inicializa el diálogo
		dialog = [
			think,"Hay un papel dentro del cajón...",
			note, "Las 4 llaves necesarias están escondidas en lugares importantes de la universidad. Su orden está indicado en el lugar donde empezó todo.",
			note, "La primera llave está donde la universidad lleva su esencia y emblema.",
			note, "La segunda se encuentra en un lugar donde se calienta la comida.",
			note, "La tercera descansa en una estantería, entre páginas llenas de conocimiento.",
			note, "La cuarta se encuentra donde se comparten anuncios importantes para la carrera de informática.",
			note, "Para conocer el orden correcto de las llaves, observa lo que se comunica en el diario mural, en el patio donde todo comienza.",
			note, "Encuentra estos lugares para terminar tu busqueda, buena suerte",
			note, "J.P.A.",
			think, "Esto va a ser mas largo de lo que creí...",
			supplayer1, "Puedes consultar una pista de donde encontrar las 5 ubicaciones si vuelves al laboratorio de informatica, pero esto tendra un punto negativo en tu puntuacion final",
			supplayer1, "Tu objetivo es resolver el enigma y encontrar los 4 digitos y su orden en las 5 ubicaciones. Buena suerte"
		]
		await get_tree().create_timer(0.5).timeout
		arrow.visible = false
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
	
	if DialogsFlags.cjrepeat == true:
		# Inicializa el diálogo
		dialog = [
			think,"La nota dentro del cajón dice:",
			note, "Las 4 llaves necesarias están escondidas en lugares importantes de la universidad. Su orden está indicado en el lugar donde empezó todo.",
			note, "La primera llave está donde la universidad lleva su esencia y emblema.",
			note, "La segunda se encuentra en un lugar donde se calienta la comida.",
			note, "La tercera descansa en una estantería, entre páginas llenas de conocimiento.",
			note, "La cuarta se encuentra donde se comparten anuncios importantes para la carrera de informática.",
			note, "Para conocer el orden correcto de las llaves, observa lo que se comunica en el diario mural, en el patio donde todo comienza."
		]
		await get_tree().create_timer(0.5).timeout
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
		DialogsFlags.cjrepeat = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	arrow.visible = true
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.cj == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
