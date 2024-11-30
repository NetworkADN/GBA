extends Node2D

@onready var transition = $Transition

@onready var TimerC = $TimerC

var next_scene = ""

var TimerClock = Clocktimer

@export var card_scene: PackedScene
@export var grid_size: Vector2 = Vector2(4, 3)
@export var card_textures: Array
@export var cards_back: Texture

var flipped_cards: Array = []
var matched_pairs: int = 0
var interaction_locked: bool = false
var fail_count: int = 0
var game_timer: float = 0.0
var timer_active: bool = false

func _ready():
	transition.play("fade_in")
	setup_board()
	TimerClock = get_tree().get_first_node_in_group("Clock")
	GlobalTimer.connect("tiempo_terminado", Callable(self, "on_tiempo_terminado"))

	# Mostrar todas las cartas durante 5 segundos
	interaction_locked = true
	for card in $Control/GridContainer.get_children():
		card.flip_card() # Voltea la carta para mostrar su lado frontal

	# Esperar 5 segundos antes de voltear las cartas
	await get_tree().create_timer(2.5).timeout

	# Voltear todas las cartas nuevamente
	for card in $Control/GridContainer.get_children():
		card.flip_card()

	interaction_locked = false
	timer_active = true  # Activar el temporizador

func setup_board():
	var total_cards = 12
	var card_ids = []

	# Crear pares de cartas
	for i in range(total_cards / 2):
		card_ids.append(i)
		card_ids.append(i)

	card_ids.shuffle()

	for i in range(total_cards):
		var card = card_scene.instantiate()
		card.card_id = card_ids[i]
		card.front_texture = card_textures[card_ids[i]]
		card.back_texture = cards_back
		card.connect("pressed", Callable(self, "_on_card_pressed").bind(card))
		$Control/GridContainer.add_child(card)


func update_clocktimer_label():
	TimerC.text = TimerClock.time_to_string()


func _on_card_pressed(card):
	# Bloquear si la interacción está deshabilitada
	if interaction_locked or card in flipped_cards:
		return

	card.flip_card()
	flipped_cards.append(card)

	if flipped_cards.size() == 2:
		interaction_locked = true
		if flipped_cards[0].card_id == flipped_cards[1].card_id:
			# Cartas coinciden
			flipped_cards.clear()
			matched_pairs += 1
			interaction_locked = false

			if matched_pairs == 6:
				timer_active = false  # Detener el temporizador
				game_over()
		else:
			# Las cartas no coinciden
			await get_tree().create_timer(1.0).timeout
			flipped_cards[0].flip_card()
			flipped_cards[1].flip_card()
			flipped_cards.clear()
			fail_count += 1  # Incrementar contador de fallos
			interaction_locked = false

func _process(delta):
	# Incrementar el temporizador si está activo
	if timer_active:
		game_timer += delta
	update_clocktimer_label()

func game_over():
	print("¡Juego terminado!")
	print("Fallos totales: %d" % fail_count)
	print("Tiempo total: %.2f segundos" % game_timer)
	DialogsFlags.lab_puzzle = true
	next_scene = "res://Scenes/Labs/PC.tscn"
	transition.play("fade_out")
	# Aquí puedes cambiar de escena o mostrar un mensaje

func on_tiempo_terminado():
	next_scene = "res://Scenes/Extras/End_time.tscn"
	AudioPlayer.stop()
	transition.play("fade_out")

func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
