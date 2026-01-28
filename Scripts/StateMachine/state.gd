extends Node
class_name State

signal ChangeStateTo(nextStateName : StringName)
@export var character : CharacterBody3D

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
