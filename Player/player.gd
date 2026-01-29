extends CreatureController
class_name PlayerController

@onready var camera : Camera3D = $CameraController/Camera3D
@onready var crouchShapeCast : ShapeCast3D = %ShapeCast3D

@export_category("Camera Settings")
@export var mouse_sensitivity : float = 0.25

func _ready() -> void:
	crouchShapeCast.add_exception($".")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		camera.rotation_degrees.x -= event.relative.y *  mouse_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func _physics_process(delta: float) -> void:
	Global.debug_menu.add_property("Camera Rotation", Vector2(camera.rotation_degrees.x, rotation_degrees.y), 1)
	Global.debug_menu.add_property("PlayerSpeed", "%.2f" % velocity.length() , 3)
	# Global.debug_menu.add_property("PlayerVelocity", velocity, 2)
	
func update_gravity(delta : float) -> void:
	velocity += get_gravity() * delta
	
func update_velocity() -> void:
	move_and_slide()

func update_input(speed : float, acceleration : float, deceleration : float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration) 
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
