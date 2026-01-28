extends CenterContainer

@export var characterController : CharacterBody3D

@export var reticleDotRadius : float = 2.0
@export var reticleDotColor : Color = Color.WHITE

@export var reticleLines : Array[Line2D]
@export var reticleSpeed : float = 0.125
@export var reticleDistance : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	
func _process(delta: float) -> void:
	adjust_reticle()

func _draw() -> void:
	draw_circle(Vector2(0,0), reticleDotRadius, reticleDotColor)

func adjust_reticle():
	var velocity = characterController.get_real_velocity()
	var origin = Vector3(0, 0, 0)
	var position = Vector2(0, 0)
	var speed = origin.distance_to(velocity)
	
	# Adjust the reticle line based off speed
	reticleLines[0].position = lerp(reticleLines[0].position, position + Vector2(0, -speed * reticleDistance), reticleSpeed)
	reticleLines[1].position = lerp(reticleLines[1].position, position + Vector2(speed * reticleDistance, 0), reticleSpeed)
	reticleLines[2].position = lerp(reticleLines[2].position, position + Vector2(0, speed * reticleDistance), reticleSpeed)
	reticleLines[3].position = lerp(reticleLines[3].position, position + Vector2(-speed * reticleDistance, 0), reticleSpeed)
