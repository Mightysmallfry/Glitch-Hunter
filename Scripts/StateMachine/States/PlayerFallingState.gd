extends State
class_name PlayerFallingState

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 6.0
@export var DOUBLE_JUMP_VELOCITY : float = 5.5

# false/true is enabled/disabled
var DOUBLE_JUMP : bool = false

func enter(previousState : State) -> void:
	ANIMATIONS.pause()

func exit() -> void:
	DOUBLE_JUMP = false
	
func update(delta : float) -> void:
	if Input.is_action_just_pressed("jump") && !DOUBLE_JUMP:
		DOUBLE_JUMP = !DOUBLE_JUMP
		CHARACTER.velocity.y = DOUBLE_JUMP_VELOCITY
	
	if CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerIdleState")
	
func physics_update(delta: float) -> void:
	CHARACTER.update_gravity(delta)
	CHARACTER.update_input(SPEED, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()
