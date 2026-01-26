extends Node

var game_manager : GameManager		# Manages Game Scenes, really a scene manager

var game_paused : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
