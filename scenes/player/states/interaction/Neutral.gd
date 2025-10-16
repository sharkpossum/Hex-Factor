extends Interaction_State

@onready var interaction_area: Area3D = %InteractionArea
@onready var player_camera: Camera3D = %PlayerCamera

var interactibles: Array[Node3D]

func Enter():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_stats.CAN_MOVE = true
	player_stats.CAN_LOOK = true
	interaction_area.reparent(player_camera, false)
	interaction_area.monitoring = true
	
func Exit():
	interaction_area.reparent(self, false)
	interaction_area.monitoring = false
	
func Update(delta: float):
	if Input.is_action_just_pressed("inventory"):
		Transitioned.emit(self, "in_inventory")
	
	# Interacts with the closest interactible to the camera position.
	if interactibles.size() > 0:
		if Input.is_action_just_pressed("interact"):
			var interaction_target = interactibles[0]
			for i in interactibles:
				if player_camera.position.distance_to(i.position) < player_camera.position.distance_to(interaction_target.position):
					interaction_target = i
			for child in interaction_target.get_children():
				if child is Interactible_Component:
					child.interact()
		
func _on_interaction_area_body_entered(body: Node3D) -> void:
	interactibles.append(body.get_parent())

func _on_interaction_area_body_exited(body: Node3D) -> void:
	interactibles.erase(body.get_parent())
