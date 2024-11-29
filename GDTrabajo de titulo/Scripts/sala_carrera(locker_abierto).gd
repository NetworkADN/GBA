extends Node2D

@onready var transition = $"ParallaxBackground/ParallaxLayer/Sala_carrera(locker_abierto)/Transition"

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_lca/Dialogo/Dialogo_lca # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_lca/nombres/caja_nombre # Nodo para el texto del nombre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")

func _process(delta):
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/M8/Sala_carrera.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
