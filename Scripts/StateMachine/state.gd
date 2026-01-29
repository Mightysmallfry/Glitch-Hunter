extends Node
class_name State

signal ChangeStateTo(nextStateName : StringName)

@export var CHARACTER : PlayerController
@export var ANIMATIONS : AnimationPlayer

func enter() -> void:
	pass
	
func exit() -> void:
	ANIMATIONS.speed_scale = 1.0
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
