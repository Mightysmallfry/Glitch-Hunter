extends Node
class_name StateMachine

@export var CurrentState : State
var States : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			States[child.name] = child
			child.ChangeStateTo.connect(_on_Change_State_To)
		else:
			push_warning("StateMachine contains invalid child node")
			
	CurrentState.enter(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CurrentState.update(delta)
	Global.debug_menu.add_property("Player State", CurrentState.name, 0)
	
func _physics_process(delta: float) -> void:
	CurrentState.physics_update(delta)

func _on_Change_State_To(nextStateName : String) -> void:
	var newState = States.get(nextStateName)
	if newState != null:
		if newState != CurrentState:
			CurrentState.exit()
			newState.enter(CurrentState)
			CurrentState = newState
	else:
		push_warning("Chosen state does not exist")
