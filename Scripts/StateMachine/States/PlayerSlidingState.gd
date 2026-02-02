extends State
class_name PlayerSlidingState

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 7.5
@export var TILT : float = 0.09
@export var SLIDE_ANIMATION_SPEED : float = 4.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

func enter(previousState : State) -> void:
	set_tilt(CHARACTER.currentRotation)
	ANIMATIONS.get_animation("sliding").track_set_key_value(4, 0, CHARACTER.velocity.length())
	ANIMATIONS.speed_scale = 1.0
	ANIMATIONS.play("sliding", -1.0, SLIDE_ANIMATION_SPEED)

func update(delta : float) -> void:
	pass
		
func physics_update(delta : float) -> void:
	CHARACTER.update_gravity(delta)
	# CHARACTER.update_input(SPEED, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()

func set_tilt(rotation : float) -> void:
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT * rotation, -0.1, 0.1)
	if tilt.z == 0.0:
		tilt.z = 0.05
	ANIMATIONS.get_animation("sliding").track_set_key_value(7, 1, tilt)
	ANIMATIONS.get_animation("sliding").track_set_key_value(7, 2, tilt)
	
	
func finish() -> void:
	ChangeStateTo.emit("PlayerCrouchingState")
