extends Node2D
@onready var cancion=$escenamario

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cancion.play() #incializamos el sonido de la escena :D
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
