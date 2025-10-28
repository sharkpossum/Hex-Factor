extends Player_Interaction_State

class_name Player_Exploring_State

@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_cast = %InteractCast

var interaction_target: Node3D
var interaction_target_component: Interactible_Component
var player_inventory_component

func Enter():
	if !player_inventory_component:
		for c in player.get_meta("components"):
			if c is Inventory_Component:
				player_inventory_component = c

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func Exit():
	pass

func Physics_Update(_delta: float):
	if Input.is_action_just_pressed("hotkey_1"):
		player_stats.SET_FOCUS_SLOT(0)
	elif Input.is_action_just_pressed("hotkey_2"):
		player_stats.SET_FOCUS_SLOT(1)
	elif Input.is_action_just_pressed("hotkey_3"):
		player_stats.SET_FOCUS_SLOT(2)
	elif Input.is_action_just_pressed("hotkey_4"):
		player_stats.SET_FOCUS_SLOT(3)
	
	if Input.is_action_just_pressed("previous_hotbar_item"):
		player_stats.SET_FOCUS_SLOT(player_stats.FOCUSED_SLOT - 1)
	if Input.is_action_just_pressed("next_hotbar_item"):
		player_stats.SET_FOCUS_SLOT(player_stats.FOCUSED_SLOT + 1)
	
	var result = interact_cast.get_collider();
	
	if result != interaction_target:
		change_interaction_target(result)
					
func change_interaction_target(new_target: Node3D):
	if interaction_target_component:
		interaction_target_component.unhighlight()
	
	interaction_target = new_target
	
	if interaction_target:
		for c in interaction_target.get_meta("components"):
			if c is Interactible_Component:
				interaction_target_component = c
				interaction_target_component.highlight()

func Update(_delta: float):
	if Input.is_action_just_pressed("inventory"):
		Transitioned.emit(self, "in_inventory")
	
	if Input.is_action_just_pressed("interact"):
		if interaction_target_component:
			interaction_target_component.unhighlight()
			interaction_target_component.interact_with_source(player)
