extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var downgravity = 1100
@onready var animacion := $AnimatedSprite2D
@onready var saltosonido :=$sonidosalto
##funciones para el personaje
func _physics_process(delta: float) -> void:
#agregamos la gravedad para nuestro personaje
	if not is_on_floor(): #le decimos que si esta en el piso
		if Input.is_action_pressed("arriba") and velocity.y >0: #y si se mantiene presionado
			velocity.y += downgravity*delta/6 # se divide la gravedad por 6 para que el descenco sea mas lento para que "planee
			if is_on_floor():
				saltosonido.play() # sonido para cada vez que salte
				
		else:
			velocity.y += downgravity * delta # y si se suelta arriba el mismo cae normalmente como lo haria con gravedad * delta

	# cada vez que presione y si esta en el piso, subira por la velocidad de salto
	if Input.is_action_just_pressed("arriba") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# le declaramos un input, para el movimiento del personaje
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
#declaramos un move toward, que detenga al personaje si las teclas no estan siendo presionadas
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#ANIMACION
	if velocity.x != 0: # si velocidad en X no es igual a 0, se reproducira la caminata de mario
		$AnimatedSprite2D.animation="caminata"
		$AnimatedSprite2D.play("caminata")
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.stop() # si no se presiona mas nada las animaciones se detendram
	if velocity.y !=0: # para poner el sprite de salto
		$AnimatedSprite2D.animation="salto"
		$AnimatedSprite2D.play( "salto")
	if Input.is_action_pressed("arriba"): # y aca decimo que si se esta presionando arriba, se reproduzca el sprite de planeacion

		$AnimatedSprite2D.play("planeacion")
	
	#SONIDOS
	if is_on_floor():
		if Input.is_action_just_pressed("arriba"):
			saltosonido.play()
		#else:
			#saltosonido.stop()

	move_and_slide()
