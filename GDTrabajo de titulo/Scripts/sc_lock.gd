extends Control

# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"
var think = "Idea"
var note = "Nota"

var next_scene = ""

var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var transition = $"../ParallaxBackground/ParallaxLayer/Sala_carrera(locker)/Transition"
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_lc  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre

func _ready():
	if  DialogsFlags.c1 == true and DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.locker == true: 
		# Inicializa el diálogo
		dialog = [
			think,"Finalmente tengo todos los digitos, vamos a ver...",
			think,"1... 0... 4... 1... *Click*",
			think,"¡Se abrió! a ver que hay dentro...",
			
		]
		await get_tree().create_timer(1).timeout
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
		
	if  DialogsFlags.locker == false and DialogsFlags.sc == true: 
		# Inicializa el diálogo
		dialog = [
			think,"Este es el locker, hay un codigo de 4 digitos en él, supongo que debo buscar los numeros...",
		]
		await get_tree().create_timer(1).timeout
		dialog_box.visible = true
		name_box.visible = true
		dialog_label.visible = true
		name_label.visible = true
	
		name_label.bbcode_text = player1
		dialog_label.bbcode_text = "..."
	
	if (DialogsFlags.c1 == false or DialogsFlags.c2 == false or DialogsFlags.c3 == false or DialogsFlags.c4 == false) and DialogsFlags.locker == true: 
		# Inicializa el diálogo
		dialog = [
			think,"Aun me faltan numeros para abrir el candado, supongo que debo seguir buscando...",
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
		if  DialogsFlags.locker == false and DialogsFlags.sc == true: 
			DialogsFlags.locker = true
			
		if  DialogsFlags.c1 == true and DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.locker == true:
			next_scene = "res://Scenes/M8/Sala_carrera(locker_abierto).tscn"
			transition.play("fade_out")
			


func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	# Detecta presionar una tecla para avanzar
	if  (DialogsFlags.c1 == false or DialogsFlags.c2 == false or DialogsFlags.c3 == false or DialogsFlags.c4 == false) and DialogsFlags.locker == true: 
		if event.is_action_pressed("ui_accept"):
			show_next_line()
	
	if  DialogsFlags.locker == false and DialogsFlags.sc == true: 
		if event.is_action_pressed("ui_accept"):
			show_next_line()
	
	if  DialogsFlags.c1 == true and DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.locker == true:
		if event.is_action_pressed("ui_accept"):
			show_next_line()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if  DialogsFlags.c1 == true and DialogsFlags.c2 == true and DialogsFlags.c3 == true and DialogsFlags.c4 == true and DialogsFlags.locker == true: 
		get_tree().change_scene_to_file(next_scene)
