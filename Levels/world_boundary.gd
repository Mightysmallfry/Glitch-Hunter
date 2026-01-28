extends Area3D

@onready var timer : Timer = $Timer

func _on_body_entered(body: Node3D) -> void:
	print("Object out of bounds: " + body.name)
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
