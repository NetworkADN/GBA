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
@onready var transition = $"../ParallaxBackground/ParallaxLayer/Sala_carrera(cajonera)/Transition"
@onready var dialog_box = $"../caja_dialogo"  # Nodo para el cuadro de diálogo
@onready var name_box = $"../Caja_nombre"  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo/Dialogo_cj  # Nodo para el texto del diálogo
@onready var name_label = $nombres/caja_nombre  # Nodo para el texto del nombre
@onready var arrow = $"../ParallaxBackground/ParallaxLayer/Sala_carrera(cajonera)/Button"

func _ready():
	if  DialogsFlags.cj == false and DialogsFlags.sc == true: 
		# Inicializa el diálogo
		dialog = [
			think,"Según la nota del laboratorio, en esta cajonera deberia haber una pista de donde buscar la clave para el candado del locker",
			think,"Voy a abrirlo a ver que hay dentro...",
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
		DialogsFlags.cj = true
		next_scene = "res://Scenes/M8/Sala_carrera(cajonera_abierta).tscn"
		transition.play("fade_out")



func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	arrow.visible = true
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	

func _input(event):
	if  DialogsFlags.cj == false and DialogsFlags.sc == true: 
		if event.is_action_pressed("ui_accept"):
			show_next_line()



func _on_transition_animation_finished(anim_name: StringName) -> void:
	if  DialogsFlags.cj == true: 
		get_tree().change_scene_to_file(next_scene)
