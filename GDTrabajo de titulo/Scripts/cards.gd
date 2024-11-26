extends Button

@export var card_id: int = 0
@export var front_texture: Texture
@export var back_texture: Texture

var is_revealed: bool = false

func flip_card():
	is_revealed = !is_revealed
	if is_revealed:
		$TextureRect.texture = front_texture
	else:
		$TextureRect.texture = back_texture
