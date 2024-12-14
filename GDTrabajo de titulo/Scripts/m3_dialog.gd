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
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $m3/Dialogo_m3  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Sala_m3/Button"
@onready var pizarra = $"../ParallaxBackground/ParallaxLayer/Sala_m3/Area2D"

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
		await get_tree().create_timer(0.5).timeout
		pizarra.visible = false
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
	
	if DialogsFlags.m3_final == false and DialogsFlags.m3_puzzle == true:
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
		await get_tree().create_timer(0.5).timeout
		pizarra.visible = false
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
		name_label.bbcode_text = dialog[current_line]  # Nombre del hablante
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
		if name_label.text == DialogsFlags.guard or name_label.text == DialogsFlags.sec or name_label.text == DialogsFlags.prof or name_label.text == DialogsFlags.note or name_label.text == DialogsFlags.vic or name_label.text == DialogsFlags.student or name_label.text == DialogsFlags.obt:
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
		DialogsFlags.m3 = true
		if DialogsFlags.m3 == true and DialogsFlags.m3_puzzle == true:
			DialogsFlags.m3_final = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	arrow.visible = true
	if DialogsFlags.m3_puzzle == false:
		pizarra.visible = true
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.m3 == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
			
	if DialogsFlags.m3 == true and DialogsFlags.m3_puzzle == true and DialogsFlags.m3_final == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
