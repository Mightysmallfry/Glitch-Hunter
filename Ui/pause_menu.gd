extends Control

func _ready() -> void:
	visible = false;
	Global.game_paused = false;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		handle_resume();

func _on_resume_button_pressed() -> void:
	handle_resume()

func _on_restart_button_pressed() -> void:
	Global.game_manager.reload_current_world_3d()
	handle_resume()

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func handle_resume() -> void:
	if (!Global.game_paused):
		visible = true;
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		visible = false;
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	Global.game_paused = !Global.game_paused
