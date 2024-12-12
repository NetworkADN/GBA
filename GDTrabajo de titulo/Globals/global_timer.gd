extends Node

@export var tiempo_inicial: float = 1200 #1800 = 30min # 5 minutos (ajústalo según necesites)
var tiempo_restante: float = tiempo_inicial
var temporizador_activo: bool = false
var ft = false

signal tiempo_actualizado(tiempo_restante)
signal tiempo_terminado()

func _process(delta: float) -> void:
	if temporizador_activo and tiempo_restante > 0:
		tiempo_restante -= delta
		emit_signal("tiempo_actualizado", tiempo_restante)
		if tiempo_restante <= 0:
			tiempo_restante = 0
			temporizador_activo = false
			emit_signal("tiempo_terminado")

func iniciar_temporizador():
	temporizador_activo = true

func pausar_temporizador():
	temporizador_activo = false

func reiniciar_temporizador():
	tiempo_restante = tiempo_inicial
	temporizador_activo = false
