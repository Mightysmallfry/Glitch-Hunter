extends State
class_name PlayerIdleState

@export var ANIMATIONS : AnimationPlayer

func enter() -> void:
	ANIMATIONS.pause()

func update(delta : float) -> void:
	if character.velocity.length() > 0.0 && character.is_on_floor():
		ChangeStateTo.emit("PlayerWalkingState")
	
