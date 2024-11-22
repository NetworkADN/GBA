extends Node2D


@onready var dialog_box = $caja_dialogo  # Nodo para el cuadro de diálogo
@onready var name_box = $Caja_nombre  # Nodo para el cuadro del nombre
@onready var dialog_label = $Dialogo_mesa/Dialogo/Dialogo_mesa # Nodo para el texto del diálogo
@onready var name_label = $Dialogo_mesa/nombres/caja_nombre  # Nodo para el texto del nombre

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.visible = false
	name_box.visible = false
	dialog_label.visible = false
	name_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
