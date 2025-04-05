extends Node2D

var escena_bomba = preload("res://bomba.tscn")
var puntuacion = 0
var tiempo_generacion = 1.0  # Tiempo en segundos entre cada bomba

func _ready():
	# Añadir la nave a la escena
	var nave = load("res://nave.tscn").instantiate()
	nave.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 100)
	add_child(nave)
	
	# Iniciar temporizador para generar bombas
	$GeneradorTimer.wait_time = tiempo_generacion
	$GeneradorTimer.start()

func _on_GeneradorTimer_timeout():
	# Crear una nueva bomba
	var bomba = escena_bomba.instantiate()
	
	# Posición aleatoria en X
	var posicion_x = randf_range(0, get_viewport_rect().size.x)
	bomba.position = Vector2(posicion_x, -10)  # Justo encima de la pantalla
	
	# Añadir la bomba a la escena
	add_child(bomba)
	
	# Aumentar puntuación
	puntuacion += 1
	
func game_over():
	print("Juego terminado")
	# Detiene el generador de bombas
	$GeneradorTimer.stop()
	
	# Muestra mensaje de Game Over
	var game_over_label = Label.new()
	game_over_label.text = "¡GAME OVER! " 
	game_over_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	game_over_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Ajusta el tamaño y posición
	game_over_label.set_anchors_preset(Control.PRESET_CENTER)
	
	# Añade el label al CanvasLayer
	$CanvasLayer.add_child(game_over_label)
	
	# Habilita reinicio con tecla R
	set_process_input(true)
