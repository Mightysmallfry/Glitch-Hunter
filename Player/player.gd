extends CharacterBody3D


@onready var camera : Camera3D = $CameraController/Camera3D

@export_category("Movement Settings")
@export var SPEED : float = 7.5
@export var JUMP_VELOCITY : float = 5.5
@export var ACCELERATION : float = 0.2
@export var DECELERATION : float = 0.375


var currentSpeed : float = 0.0

@export_category("Camera Settings")
@export var mouse_sensitivity : float = 0.25


func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		camera.rotation_degrees.x -= event.relative.y *  mouse_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func _physics_process(delta: float) -> void:
	Global.debug_menu.add_property("Camera Rotation", Vector2(camera.rotation_degrees.x, rotation_degrees.y), 1)
	Global.debug_menu.add_property("PlayerVelocity", velocity, 2)
	Global.debug_menu.add_property("PlayerSpeed", velocity.length(), 3)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION) 
		velocity.z = lerp(velocity.z, direction.z * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	move_and_slide()
