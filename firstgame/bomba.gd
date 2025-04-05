extends Area2D

var velocidad = 200  # Velocidad de caída

func _ready():
	# Añadir la bomba al grupo "bombas" para detectar colisiones
	add_to_group("bombas")

func _process(delta):
	# Mover hacia abajo
	position.y += velocidad * delta
	
	# Eliminar la bomba si sale de la pantalla
	if position.y > get_viewport_rect().size.y + 10:
		queue_free()
