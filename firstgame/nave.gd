extends Area2D

var velocidad = 400  # Velocidad de movimiento en píxeles/segundo
var tamanio_pantalla = Vector2.ZERO

func _ready():
	# Obtener el tamaño de la pantalla
	tamanio_pantalla = get_viewport_rect().size
	
	# Conectar señal de colisión
	#connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	# Obtener dirección de movimiento
	var direccion = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direccion.x += 1
	if Input.is_action_pressed("ui_left"):
		direccion.x -= 1
	if Input.is_action_pressed("ui_down"):
		direccion.y += 1
	if Input.is_action_pressed("ui_up"):
		direccion.y -= 1
	
	# Normalizar para movimiento diagonal uniforme
	if direccion.length() > 0:
		direccion = direccion.normalized()
	
	# Mover la nave
	position += direccion * velocidad * delta
	
	# Limitar la posición dentro de la pantalla
	position.x = clamp(position.x, 0, tamanio_pantalla.x)
	position.y = clamp(position.y, 0, tamanio_pantalla.y)

func _on_area_entered(area: Area2D) -> void:
	print("Colisión detectada con: ", area.name)  # Para depuración
	if area.is_in_group("bombas"):
		print("¡Boom! Game Over")
		# Notificar al nodo principal (Juego) sobre el game over
		var juego_nodo = get_node("/root/Juego")  # Ajusta la ruta si es necesaria
		if juego_nodo.has_method("game_over"):
			juego_nodo.game_over()
	
		# Ocultar la nave
		visible = false
		# Desactivar colisiones para evitar múltiples detecciones
		$CollisionShape2D.set_deferred("disabled", true)
