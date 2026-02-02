extends State
class_name PlayerIdleState

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 1.0

func enter(previousState : State) -> void:
	ANIMATIONS.play("idle")

func update(delta : float) -> void:
	if CHARACTER.velocity.length() > 0.0 && CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerWalkingState")

	if Input.is_action_just_pressed("jump") && CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerJumpState")
		
	if CHARACTER.velocity.y < -0.1 && !CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerFallingState")
		
	if Input.is_action_just_pressed("crouch") && CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerCrouchingState")

func physics_update(delta : float) -> void:
	CHARACTER.update_gravity(delta)
	CHARACTER.update_input(SPEED, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()
	
