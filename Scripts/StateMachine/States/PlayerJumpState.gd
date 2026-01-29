extends State
class_name PlayerJumpState

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 6.0

@export var JUMP_VELOCITY : float = 5.5
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLIER : float = 0.85

func enter() -> void:
	CHARACTER.velocity.y += JUMP_VELOCITY
	ANIMATIONS.pause()
	
func update(delta : float) -> void:
	if CHARACTER.is_on_floor(): 
		ChangeStateTo.emit("PlayerIdleState")
		
	if CHARACTER.velocity.y < -0.1 && !CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerFallingState")
	
func physics_update(delta: float) -> void:
	CHARACTER.update_gravity(delta)
	CHARACTER.update_input(SPEED * INPUT_MULTIPLIER, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()
