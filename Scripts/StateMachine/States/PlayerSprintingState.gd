extends State
class_name PlayerSprintingState

@export var TOP_ANIMATION_SPEED : float = 1.8;

@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375
@export var SPEED : float = 10.0

func enter(previousState : State) -> void:
	ANIMATIONS.play("sprinting", 0.5, 1.0)


func update(delta : float) -> void:	
	set_animation_speed(CHARACTER.velocity.length())
	if Input.is_action_just_released("sprint"):
		ChangeStateTo.emit("PlayerWalkingState")
	
	if CHARACTER.velocity.length() == 0.0:
		ChangeStateTo.emit("PlayerIdleState")
		
	if Input.is_action_just_pressed("jump") && CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerJumpState")
		
	if CHARACTER.velocity.y < -0.1 && !CHARACTER.is_on_floor():
		ChangeStateTo.emit("PlayerFallingState")
	
	if Input.is_action_just_pressed("crouch") && CHARACTER.velocity.length() > 2.0:
		ChangeStateTo.emit("PlayerSlidingState")
		
func physics_update(delta: float) -> void:
	CHARACTER.update_gravity(delta)
	CHARACTER.update_input(SPEED, ACCELERATION, DECELERATION)
	CHARACTER.update_velocity()

func set_animation_speed(speed : float) -> void:
	var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
	ANIMATIONS.speed_scale = lerp(0.0, TOP_ANIMATION_SPEED, alpha)
