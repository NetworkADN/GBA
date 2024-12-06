extends Node2D

@onready var transition = $ParallaxBackground/ParallaxLayer/PC/Transition

@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer


@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_pc/Dialogo/Dialogo_pc# Nodo para el texto del diálogo
@onready var name_label = $Dialogo_pc/nombres/caja_nombre  # Nodo para el texto del nombre
@onready var app = $ParallaxBackground/ParallaxLayer/PC/App

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DialogsFlags.lab_puzzle == true:
		app.visible = false
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))

func _process(delta):
	update_clocktimer_label()


func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Labs/Lab_de_info.tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()


func _on_app_pressed() -> void:
	next_scene = "res://Scenes/memorice/memorice.tscn"
	transition.play("fade_out")


func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
