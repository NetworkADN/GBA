extends Control
# Variables
var player1 = "Yo"
var supplayer1 = "Objetivo"

var end = false
var dialog = []  # Lista de diálogos
var current_line = 0  # Línea actual del diálogo

# Referencias a nodos
@onready var transition = $"../../Transition"
@onready var dialog_box = get_parent().get_parent().get_node("caja_dialogo")  # Nodo para el cuadro de diálogo
@onready var name_box = get_parent().get_parent().get_node("Caja_nombre")  # Nodo para el cuadro del nombre
@onready var dialog_label = get_parent().get_node("Inicio/Dialogo_inicio")  # Nodo para el texto del diálogo
@onready var name_label = get_parent().get_node("nombres/caja_nombre")  # Nodo para el texto del nombre

func _ready():
	# Inicializa el diálogo
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	GlobalTimer.ft = false
	GlobalTimer.reiniciar_temporizador()
	dialog = [
		player1, "Aquí estoy, mi primer día como ayudante.",
		player1, "Aún tengo tiempo antes de que comience la ayudantía, debería ir a la escuela a solicitar las llaves de la sala.",
		supplayer1, "Tu primer objetivo es ir a la escuela a buscar las llaves de la sala del laboratorio de informática.",
		supplayer1, "Ten en cuenta que debes hacerlo antes de que comiencen las ayudantías, esto es en 30 minutos.",
		supplayer1, "Si no lo logras antes de ese tiempo, el juego se da por terminado. El tiempo comienza a correr cuando se cierre este diálogo.",
		supplayer1, "¡Buena suerte!"
	]
	transition.play("fade_in")
	await get_tree().create_timer(2).timeout
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
		transition.play("fade_out")

func close_dialog_boxes():
	# Oculta el cuadro de diálogo y el nombre al terminar
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	end = true
	


func _input(event):
	# Detecta presionar una tecla para avanzar
	if event.is_action_pressed("ui_accept"):
		show_next_line()



func _on_transition_animation_finished(anim_name):
	if end == true:
		get_tree().change_scene_to_file("res://Scenes/Entradas/entrada.tscn")
