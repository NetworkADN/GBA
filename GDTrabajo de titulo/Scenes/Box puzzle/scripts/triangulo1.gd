extends Node2D

var selected = false
var mouse_offset = Vector2(0, 0)
var target_position = null  # Almacena la posición del collider
var snapped = false  # Indica si la figura ya está colocada
var x = 1023
var y = 286


func _process(delta: float) -> void:
	if selected and not snapped:
		follow_mouse()

func follow_mouse() -> void:
	position = get_global_mouse_position() + mouse_offset

# Manejador del evento de clic
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and not snapped:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false
			if target_position:
				snap_to_target()
			else:
				GlobalCalcs.tries_box +=1

# Ajustar figura al collider
func snap_to_target() -> void:
	position.x = x
	position.y = y
	DialogsFlags.t1 = true
	snapped = true  # Bloquea el movimiento



func _on_area_2d_area_entered(area):
	if area.is_in_group("Triangulo1"):  # Si el collider es el correspondiente
		print("Detectado area2d")
		target_position = $"../../Colliders_figuras/triangulo_1".position  # Guarda la posición del collider


func _on_area_2d_area_exited(area):
	if area.is_in_group("Triangulo1") and not snapped:  # Si no está colocada, borra el target
		target_position = null
