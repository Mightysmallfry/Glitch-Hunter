extends State
class_name PlayerCrouchingState

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 7.5
@export var CROUCH_SPEED : float = 4.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D
var RELEASED : bool = false

func enter(previousState : State) -> void:
	ANIMATIONS.speed_scale = 1.0
	if (previousState.name != "PlayerSlidingState"):
		ANIMATIONS.play("crouch", -1, CROUCH_SPEED)
	elif previousState.name == "PlayerSlidingState":
		ANIMATIONS.current_animation = "crouch"
		ANIMATIONS.seek(1.0, true)
	
func exit() -> void:
	RELEASED = false
	
func update(delta : float) -> void:
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("crouch") == false && RELEASED == false:
		RELEASED = true
		uncrouch()
	
func physics_update(delta : float) -> void:
	CHARACTER.update_gravity(delta)
	CHARACTER.update_input(SPEED, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()

func uncrouch() -> void: 
	if !CROUCH_SHAPECAST.is_colliding() && !Input.is_action_pressed("crouch"):
			ANIMATIONS.play("crouch", -1, -CROUCH_SPEED, true)
			if ANIMATIONS.is_playing():
				await ANIMATIONS.animation_finished
			ChangeStateTo.emit("PlayerIdleState")
	elif CROUCH_SHAPECAST.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
