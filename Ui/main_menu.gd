extends Control

var PauseMenuPath : String = "res://Ui/pause_menu.tscn"
var StartingLevel : String = "res://Levels/level_one.tscn"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.game_manager.change_gui_scene(PauseMenuPath, true, false)
	Global.game_manager.change_3d_scene(StartingLevel)
	
	self.queue_free()

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit();
