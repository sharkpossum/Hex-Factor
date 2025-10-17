extends Node
class_name State_Machine

@export var initial_state: State

var current_state: State
var states : Dictionary = {}

signal StateChanged

func _ready() -> void:
	get_parent().State_Parent_Ready.connect(on_parent_ready)
	pass

func on_parent_ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state;
		StateChanged.emit(current_state.name)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)
	pass

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta);
		pass
	pass
	
func override_state(new_state_name):
	change_state(new_state_name)
	pass

func on_child_transition(state: State, new_state_name):
	if state != current_state:
		return
	change_state(new_state_name)
	
func change_state(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit();
	new_state.Enter();

	current_state = new_state
	StateChanged.emit(current_state.name)
	pass
