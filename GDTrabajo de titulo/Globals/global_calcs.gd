extends Node

var time_box = 0.0
var time_memo = 0.0
var time_ecu = 0.0
var time_left = 0.0

var tries_box = 0
var tries_memo = 0
var tries_ecu = 0

var com1_score = 0.0
var com2_score = 0.0
var com3_score = 0.0
var com4_score = 0.0

var helped = false

var ft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Calculos_de_comp():
	
	time_left = GlobalTimer.tiempo_restante
	helped = DialogsFlags.help
	ft = true
	
	# Memorice
	if tries_memo <=2:
		com3_score += 3
		
	elif tries_memo <= 4 and tries_memo > 2:
		com3_score += 2
		
	elif tries_memo <= 8 and tries_memo > 4:
		com3_score += 1
		
	else:
		com3_score += 0
		
	if time_memo <= 15:
		com3_score += 2
		
	elif time_memo > 15 and time_memo <= 30:
		com3_score += 1
		
	else:
		com3_score += 0

	# Caja
	
	if tries_box <= 5:
		com2_score += 2
		
	elif tries_box <= 8 and tries_box > 5:
		com2_score += 1
		
	else:
		com2_score += 0
		
	if time_box <= 20:
		com2_score += 3
		
	elif time_box > 20 and time_box <= 40:
		com2_score += 2
		
	elif time_box > 40 and time_box <= 70:
		com2_score += 1
		
	else:
		com2_score += 0

	# Ecuacion
	
	if tries_ecu <=1:
		com1_score += 2
		
	elif tries_ecu <= 3 and tries_ecu > 1:
		com1_score += 1
		
	else:
		com1_score += 0
		
	if time_ecu <= 40:
		com1_score += 3
		
	elif time_ecu > 40 and time_ecu <= 80:
		com1_score +=2
		
	elif time_ecu > 80 and time_ecu <= 120:
		com1_score +=1
		
	else:
		com1_score += 0
		
	# Competencia Global
	
	if time_left >= 900:
		com4_score += 4
	elif time_left < 900 and time_left >= 600:
		com4_score += 3
	elif time_left < 600 and time_left >= 300:
		com4_score += 2
	elif time_left < 300 and time_left >= 1:
		com4_score += 1
	else:
		com4_score = 0
	
	if helped == false:
		com4_score += 1
	else:
		com4_score += 0
