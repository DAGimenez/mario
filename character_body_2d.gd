extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var downgravity = 980
@onready var animacion := $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("arriba") and velocity.y >0:
			velocity.y += downgravity*delta/6
			
		else:
			velocity.y += downgravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("arriba") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x != 0:
		$AnimatedSprite2D.animation="caminata"

	move_and_slide()
