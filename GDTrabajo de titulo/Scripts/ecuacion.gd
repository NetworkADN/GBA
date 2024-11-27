extends Control

@onready var feedback_timer = $Timer
@onready var timer = $Timer2
@onready var transition = $transition2
@export var correct_answer: String = "49"  # La respuesta correcta (puedes modificarla)
@onready var answer_input =  $LineEdit   # Referencia al LineEdit
@onready var ok_button = $caja_ok/ok     # Referencia al botón OK
@onready var back = $caja_atras/back
@onready var feedback_label = $Respuesta  # Referencia al Label para mostrar mensajes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_ok_pressed() -> void:
	var user_answer = answer_input.text.strip_edges()  # Obtiene el texto ingresado y elimina espacios
	if user_answer == correct_answer:
		feedback_label.text = "¡Respuesta correcta!"  # Mensaje para respuesta correcta
		feedback_label.modulate = Color(0, 1, 0)  # Cambia el color del texto a verde
		answer_input.editable = false
		ok_button.visible = false
		back.visible = false
		DialogsFlags.m3_puzzle = true
		timer.start(2.0)
		feedback_timer.start(2.0)
	else:
		back.disabled = true
		feedback_label.text = "Respuesta incorrecta. Intenta de nuevo."  # Mensaje para respuesta incorrecta
		feedback_label.modulate = Color(1, 0, 0)  # Cambia el color del texto a rojo
		feedback_timer.start(2.0)


func _on_timer_timeout() -> void:
	feedback_label.text = "" 
	back.disabled = false 


func _on_timer_2_timeout() -> void:
	answer_input.visible = false
	transition.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/M3/Sala_m3.tscn")
