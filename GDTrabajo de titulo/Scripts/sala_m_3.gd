extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/Sala_m3/Transition
@onready var sprite = $ParallaxBackground/ParallaxLayer/Sala_m3/Area2D/Sprite2D
@onready var area2d = $ParallaxBackground/ParallaxLayer/Sala_m3/Area2D

@export var normal_color: Color = Color(1, 1, 1, 1)    # Color normal
@export var hover_color: Color = Color(1, 1, 0.8, 1)  # Color iluminado

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_m3/m3/Dialogo_m3 # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_m3/nombres/caja_nombre  # Nodo para el texto del nombre
@onready var obj_label = $Objetivo #Label de objetivo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DialogsFlags.m3_puzzle == true or DialogsFlags.escuela == false:
		sprite.visible = false
		area2d.visible = false
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))

func _process(delta):
	if DialogsFlags.escuela == false:
		obj_label.text = "Objetivo: Ir a escuela"
	elif DialogsFlags.m3 == false:
		obj_label.text = "Objetivo: Ir al M3"
	elif DialogsFlags.m3_puzzle == false or DialogsFlags.m3_final == false:
		obj_label.text = "Objetivo: Resolver la ecuación"
	elif DialogsFlags.bibl == false:
		obj_label.text = "Objetivo: Ir a la biblioteca"
	elif DialogsFlags.bibl_puzzle == false or DialogsFlags.bibl_final == false:
		obj_label.text = "Objetivo: Revisa la sala multiuso"
	elif DialogsFlags.lab == false:
		obj_label.text = "Objetivo: Ir al laboratorio"
	elif DialogsFlags.lab_puzzle == false or DialogsFlags.lab_final == false:
		obj_label.text = "Objetivo: Revisar el laboratorio"
	elif DialogsFlags.sc == false:
		obj_label.text = "Objetivo: Ir a la sala de carrera"
	elif DialogsFlags.sc_puzzle == false or DialogsFlags.key == false:
		obj_label.text = "Objetivo: Busca la clave"
	else:
		obj_label.text = "Objetivo: Ir a la oficina en escuela"
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/M3/Pasillo salas m3.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			next_scene = "res://Scenes/M3/Pizarra.tscn"
			transition.play("fade_out")
			AudioManager.steps_audio.play()


func _on_area_2d_mouse_entered() -> void:
	sprite.modulate = hover_color

func _on_area_2d_mouse_exited() -> void:
	sprite.modulate = normal_color

func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")
