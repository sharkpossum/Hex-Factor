extends Player_Interaction_State

@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_cast = %InteractCast

var interaction_target: Node3D
var interaction_target_component: Interactible_Component

func Enter():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func Exit():
	pass

func Physics_Update(_delta: float):
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
