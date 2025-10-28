extends Player_Interaction_State

class_name Player_In_Menu_State

@onready var player_movement_state: State_Machine = %MovementState

func Enter():
	%HotbarUI.visible = false;
	%Reticle.visible = false;
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player_stats.CAN_MOVE = false
	player_stats.CAN_LOOK = false
	player_movement_state.override_state("in_menu")
	

func Exit():
	%HotbarUI.visible = true;
	%Reticle.visible = true;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_stats.CAN_MOVE = true
	player_stats.CAN_LOOK = true
	player_movement_state.override_state("walking")
