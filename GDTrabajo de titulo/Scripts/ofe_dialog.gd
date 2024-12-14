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
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_ofe  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../Button"

func _ready():
	if DialogsFlags.key == true:
		# Inicializa el diálogo
		GlobalTimer.pausar_temporizador()
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
		await get_tree().create_timer(0.5).timeout
		arrow.visible = false
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
		
		if name_label.text == player1:
			dialog_box_sprite.modulate = DialogsFlags.player_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulate1
			name_box_sprite.modulate = DialogsFlags.player_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulate1
	


func show_next_line():
	# Avanza al siguiente diálogo
	if current_line < dialog.size():
		name_label.text = dialog[current_line]  # Nombre del hablante
		dialog_label.bbcode_text = dialog[current_line + 1]  # Texto del diálogo
		if name_label.text == player1:
			dialog_box_sprite.modulate = DialogsFlags.player_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulate1
			name_box_sprite.modulate = DialogsFlags.player_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulate1
		if name_label.text == think:
			dialog_box_sprite.modulate = DialogsFlags.think_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulatet
			name_box_sprite.modulate = DialogsFlags.think_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulatet
		if name_label.text == DialogsFlags.guard or name_label.text == DialogsFlags.sec or name_label.text == DialogsFlags.sec or name_label.text == DialogsFlags.note or name_label.text == DialogsFlags.vic or name_label.text == DialogsFlags.student or name_label.text == DialogsFlags.obt:
			dialog_box_sprite.modulate = DialogsFlags.sec_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulates
			name_box_sprite.modulate = DialogsFlags.sec_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulates
		if name_label.text == supplayer1:
			dialog_box_sprite.modulate = DialogsFlags.obj_color
			dialog_box_sprite.self_modulate = DialogsFlags.Self_modulateo
			name_box_sprite.modulate = DialogsFlags.obj_color
			name_box_sprite.self_modulate = DialogsFlags.Self_modulateo
		current_line += 2  # Avanza al siguiente par (nombre + texto)
	else:
		close_dialog_boxes()
		next_scene = "res://Scenes/Menus/Menu_score.tscn" #PONER AQUI LA REFERENCIA AL SCORE
		DialogsFlags.sc_puzzle = true
		DialogsFlags.end = true
		GlobalCalcs.Calculos_de_comp()
		print("Competencia 1: ", GlobalCalcs.com1_score)
		print("Competencia 2: ", GlobalCalcs.com2_score)
		print("Competencia 3: ", GlobalCalcs.com3_score)
		print("Competencia 4: ", GlobalCalcs.com4_score)
		AudioPlayer.stop_music()
		get_tree().change_scene_to_file(next_scene)

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
