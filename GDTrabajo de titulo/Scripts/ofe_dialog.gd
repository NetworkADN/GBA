extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var vic = "Victor"
var obt = ""
var next_scene = ""

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var transition = $"ParallaxBackground/ParallaxLayer/Sala_carrera(locker)/Transition"

@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_ofe  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	if DialogsFlags.key == true:
		# Inicializa el diálogo
		dialog = [
			player1,"¡Buenos dias profesor! Encontré esta llave y queria saber si le pertenece...",
			vic,"¡Buenos dias! Asi que al final has logrado completarlo todo ¡Buen trabajo!",
			vic,"y respondiendo a tu pregunta, asi es, esa es la llave de mi lonchera que uno de los alumnos escondió hoy, no me puedo imaginar por que alguien haría eso...",
			think,"¿Estará hablando de J.P.A.? Un momento... ¿la llave de su lonchera? ¿Es decir que esta no es la llave de la sala?",
			player1,"Profesor, esta llave... ¿Es la llave de su lonchera? yo creí que era la llave de la sala donde tengo que hacer mi ayudantía...",
			vic, "Asi es, es de mi lonchera, aunque creo que te refieres a esta llave",
			obt, "HAS OBTENIDO 'LLAVE DE LA SALA'",
			vic,"Encontre esta llave al lado de una caja extraña en la biblioteca, me preguntaba que abria... la traje conmigo para verla mas a detalle pero lo olvide",
			player1,"¡Si, esta es la llave, muchas gracias profesor!",
			vic, "Gracias a ti por encontrar la llave de mi lonchera",
			vic, "A todo esto ¿donde estaba?",
			player1, "Es una larga historia, pero la encontre en la sala de la carrera...",
			think, "Asi que la llave si estaba en la biblioteca... supongo que a veces las cosas no salen como uno espera",
			think, "Bueno, al menos ya tengo la llave y puedo ir a la ayudantia, y justo a tiempo",
			player1, "Bueno profesor, se me hace tarde para ir a la ayudantía, muchas gracias y nos vemos",
			vic, "Cuidate y buena suerte..."
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
		next_scene = "" #PONER AQUI LA REFERENCIA AL SCORE
		DialogsFlags.sc_puzzle = true
		transition.play("fade_out")

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.key == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
