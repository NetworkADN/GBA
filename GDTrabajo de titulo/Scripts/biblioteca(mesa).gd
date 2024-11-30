extends Node2D

@onready var transition = $"ParallaxBackground/ParallaxLayer/Biblioteca(mesa)/Transition"
@onready var TimerC = $TimerC
var next_scene = "" 

var TimerClock = Clocktimer

@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_mesa/Dialogo/Dialogo_mesa # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_mesa/nombres/caja_nombre  # Nodo para el texto del nombre
@onready var sprite = $"ParallaxBackground/ParallaxLayer/Biblioteca(mesa)/Caja_puzzle/caja"
@onready var area2d = $"ParallaxBackground/ParallaxLayer/Biblioteca(mesa)/Caja_puzzle/Area2D"

@export var normal_color: Color = Color(1, 1, 1, 1)    # Color normal
@export var hover_color: Color = Color(1, 1, 0.8, 1)  # Color iluminado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area2d.visible = false
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false
	transition.play("fade_in")
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))
	if DialogsFlags.m3_puzzle == true:
		area2d.visible = true
	if DialogsFlags.bibl_puzzle == true:
		area2d.visible = false

func _process(delta):
	update_clocktimer_label()

func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()

func _on_button_pressed() -> void:
	next_scene = "res://Scenes/Biblioteca/Biblioteca(sala_multiuso).tscn"
	transition.play("fade_out")
	AudioManager.steps_audio.play()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			next_scene = "res://Scenes/Box puzzle/Box(Puzzle).tscn"
			transition.play("fade_out")


func _on_area_2d_mouse_entered() -> void:
	sprite.modulate = hover_color


func _on_area_2d_mouse_exited() -> void:
	sprite.modulate = normal_color


func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
