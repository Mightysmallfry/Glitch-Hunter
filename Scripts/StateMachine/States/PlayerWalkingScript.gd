extends State
class_name PlayerWalkingState

@export var ANIMATIONS : AnimationPlayer 
@export var TopAnimationSpeed : float = 2.2;

func enter() -> void:
	ANIMATIONS.play("walking", -1.0, 1.0)

func update(delta : float) -> void: 
	set_animation_speed(character.velocity.length())
	if character.velocity.length() == 0.0:
		ChangeStateTo.emit("PlayerIdleState")

func set_animation_speed(speed : float) -> void:
	var alpha = remap(speed, 0.0, character.SPEED, 0.0, 1.0)
	ANIMATIONS.speed_scale = lerp(0.0, TopAnimationSpeed, alpha)
