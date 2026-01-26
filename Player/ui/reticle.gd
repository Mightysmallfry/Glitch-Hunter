extends CenterContainer

@export var characterController : CharacterBody3D

@export var reticleDotRadius : float = 2.0
@export var reticleDotColor : Color = Color.WHITE

@export var reticleLines : Array[Line2D]
@export var reticleSpeed : float = 0.25
@export var reticleDistance : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(0,0), reticleDotRadius, reticleDotColor)
