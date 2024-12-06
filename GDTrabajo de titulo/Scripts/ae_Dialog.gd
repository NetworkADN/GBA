extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var obt = ""
var note = "Nota"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_ae  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Anuncios_escuela/Button"

func _ready():
	if  DialogsFlags.c1 == false and DialogsFlags.cj == true: 
		# Inicializa el diálogo
		if DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.ord == true:
			dialog = [
				think,"¿Eh? Hay algo escrito en una de las esquinas",
				think,"¡Es un numero pintado en plumon negro!",
				think,"2... Supongo que es uno de los numeros para el candado",
				obt, "HAS ENCONTRADO LOS CUATRO NUMEROS Y TIENES EL ORDEN CORRECTO, VUELVE AL CASILLERO PARA INTRODUCIR LA CLAVE"
			]
		elif DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.ord == false:
			dialog = [
				think,"¿Eh? Hay algo escrito en una de las esquinas",
				think,"¡Es un numero pintado en plumon negro!",
				think,"2... Supongo que es uno de los numeros para el candado",
				obt, "HAS ENCONTRADO LOS CUATRO NUMEROS, SOLO TE FALTA ENCONTRAR EL ORDEN CORRECTO"
			]
		else:
			dialog = [
				think,"¿Eh? Hay algo escrito en una de las esquinas",
				think,"¡Es un numero pintado en plumon negro!",
				think,"2... Supongo que es uno de los numeros para el candado",
				obt, "HAS ENCONTRADO UNO DE LOS CUATRO NUMEROS"
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
		name_label.text = dialog[current_line]  # Nombre del hablante
		dialog_label.bbcode_text = dialog[current_line + 1]  # Texto del diálogo
		current_line += 2  # Avanza al siguiente par (nombre + texto)
	else:
		close_dialog_boxes()
		DialogsFlags.c1 = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrow.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	if  DialogsFlags.c1 == false and DialogsFlags.cj == true: 
		if event.is_action_pressed("ui_accept"):
			show_next_line()
	
