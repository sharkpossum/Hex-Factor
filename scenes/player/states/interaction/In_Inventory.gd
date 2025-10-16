extends Interaction_State

func Enter():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	player_stats.CAN_MOVE = false
	player_stats.CAN_LOOK = false
	
func Update(delta: float):
	if Input.is_action_just_pressed("inventory"):
		Transitioned.emit(self, "neutral")
