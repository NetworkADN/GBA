extends Sprite2D  # Cambia a Sprite si estás usando imágenes.

var original_position: Vector2
var is_dragging: bool = false

func _ready():
	original_position = position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:  # Cambiar LEFT por su valor numérico directo (1).
			if event.pressed:
				if get_global_mouse_position().distance_to(global_position) < 50:  # Ajusta el rango según tu figura
					is_dragging = true
			else:
				is_dragging = false
				if not is_overlapping_target():
					position = original_position  # Regresa a la posición inicial si no encaja

func _process(delta):
	if is_dragging:
		position = get_global_mouse_position()

func is_overlapping_target() -> bool:
	var query = PhysicsPointQueryParameters2D.new()
	query.position = global_position
	var result = get_world_2d().direct_space_state.intersect_point(query)
	for item in result:
		if item.collider.has_method("is_target") and item.collider.is_target():
			return true
	return false
