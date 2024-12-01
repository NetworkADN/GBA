extends Control

@onready var transition = $Transition
@onready var label1 = $Sprite2D/estrellas/puntuacion
@onready var label2 = $Sprite2D/estrellas2/puntuacion
@onready var label3 = $Sprite2D/estrellas3/puntuacion
@onready var label4 = $Sprite2D/estrellas4/puntuacion


@export var puntaje: int = 0
#@export var puntaje2: int = 0
#@export var puntaje3: int = 0
#@export var puntaje4: int = 0

var next_scene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Competencia 1: ", GlobalCalcs.com1_score)
	print("Competencia 2: ", GlobalCalcs.com2_score)
	print("Competencia 3: ", GlobalCalcs.com3_score)
	print("Competencia 4: ", GlobalCalcs.com4_score)
	final_score1()
	final_score2()
	final_score3()
	final_score4()
	transition.play("fade_in")

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Menus/Menu.tscn"
	transition.play("fade_out")

func final_score1() -> void:
	puntaje = GlobalCalcs.com1_score
	for i in range(5):
		var estrella = $Sprite2D/estrellas.get_node("Star" + str(i + 1))
		if i < puntaje:
			estrella.visible = true
		else:
			estrella.visible = false
	mostrar_puntuacion1()

func final_score2() -> void:
	puntaje = GlobalCalcs.com2_score
	for i in range(5):
		var estrella = $Sprite2D/estrellas2.get_node("Star" + str(i + 1))
		if i < puntaje:
			estrella.visible = true
		else:
			estrella.visible = false
	mostrar_puntuacion2()

func final_score3() -> void:
	puntaje = GlobalCalcs.com3_score
	for i in range(5):
		var estrella = $Sprite2D/estrellas3.get_node("Star" + str(i + 1))
		if i < puntaje:
			estrella.visible = true
		else:
			estrella.visible = false
	mostrar_puntuacion3()

func final_score4() -> void:
	puntaje = GlobalCalcs.com4_score
	for i in range(5):
		var estrella = $Sprite2D/estrellas4.get_node("Star" + str(i + 1))
		if i < puntaje:
			estrella.visible = true
		else:
			estrella.visible = false
	mostrar_puntuacion4()

func mostrar_puntuacion1() -> void:
	label1.text = "%d / 5 estrellas" % puntaje

func mostrar_puntuacion2() -> void:
	label2.text = "%d / 5 estrellas" % puntaje

func mostrar_puntuacion3() -> void:
	label3.text = "%d / 5 estrellas" % puntaje

func mostrar_puntuacion4() -> void:
	label4.text = "%d / 5 estrellas" % puntaje


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
