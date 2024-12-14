extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var std = "Estudiante"

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var dialog_box_sprite = $"../caja_dialogo/Dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var name_box_sprite = $"../Caja_nombre/Nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_lab  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Lab/Button"
@onready var pc = $"../ParallaxBackground/ParallaxLayer/Lab/Area2D"

func _ready():
	if DialogsFlags.lab == false and DialogsFlags.bibl_final == true:
		# Inicializa el diálogo
		dialog = [
			think, "Uff subir esas escaleras siempre me deja cansado, al menos ya llegue al laboratorio",
			think, "¿Ese es el PC al que hacia referencia la nota?",
			think, "Parece que tiene un juego abierto...",
			think, "Le voy a echar un vistazo",
		]
		await get_tree().create_timer(0.5).timeout
		pc.visible = false
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
		
	if DialogsFlags.cj == true and (DialogsFlags.c1 == false or DialogsFlags.c2 == false or DialogsFlags.c3 == false or DialogsFlags.c4 == false or DialogsFlags.ord == false) and DialogsFlags.help == false:
		# Inicializa el diálogo
		dialog = [
			think, "Estoy algo perdido y me queda poco tiempo...",
			std, "Hola, ¿sucede algo?, te veo algo agobiado...",
			player1, "No es nada, estoy buscando una llave pero sigo encontrandome con problemas tras problemas, ahora resulta que debo resolver un acertijo para encontrarla",
			player1, "y la verdad no entiendo mucho a que se refiere...",
			std, "Dejame ver la nota con el acertijo...",
			std, "mmmm... creo que lo entiendo un poco",
			std, "'Donde la universidad lleva su esencia y emblema', ¿Tendra algo que ver con el logo de la universidad en el patio del transa? deberias revisar ahí",
			std, "'Un lugar donde se calienta la comida', puede estar hablando de el casino, y si es asi de uno de los microondas",
			std, "'Una estantería, entre páginas llenas de conocimiento', se me ocurre que puede ser la biblioteca, en las estanterias con libros",
			std, "'Anuncios importantes para la carrera de informática', debe ser el tablero de anuncios frente a escuela, no se me ocurre otro lugar",
			std, "'El diario mural, en el patio donde todo comienza', esto puede referirse al diario mural en el pasillo del primer patio, antes de llegar al casino",
			std, "Eso es todo lo que se me ocurre, ahora debo ir a una clase que tengo, espero haberte ayudado",
			player1, "Me has ayudado mucho, gracias",
			std, "Encantado de ayudar, ¡Nos vemos!",
			think, "Ahora tengo una mejor idea de donde buscar lo que me falta",
			think, "A todo esto... ¿Quien era el y por que me ayudó tan 'convenientemente'?¿Será J.P.A.?",
			think, "Mejor no le doy mas vueltas, no me queda mucho tiempo...",
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
		if DialogsFlags.cj == true and (DialogsFlags.c1 == false or DialogsFlags.c2 == false or DialogsFlags.c3 == false or DialogsFlags.c4 == false or DialogsFlags.ord == false):
			close_dialog_boxes()
			DialogsFlags.help = true
		if DialogsFlags.lab == false and DialogsFlags.bibl_final == true:
			close_dialog_boxes()
			DialogsFlags.lab = true

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrow.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	if DialogsFlags.lab_puzzle == false:
		pc.visible = true
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if DialogsFlags.lab == false and DialogsFlags.bibl_puzzle == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
	if DialogsFlags.cj == true and (DialogsFlags.c1 == false or DialogsFlags.c2 == false or DialogsFlags.c3 == false or DialogsFlags.c4 == false or DialogsFlags.ord == false) and DialogsFlags.help == false:
		if event.is_action_pressed("ui_accept"):
			show_next_line()
