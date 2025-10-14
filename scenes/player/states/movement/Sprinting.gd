extends Player_Movement_State

@export var SPRINT_TOGGLE: bool = true

func Update(delta):
	if !SPRINT_TOGGLE:
		if Input.is_action_just_released("sprint"):
			Transitioned.emit(self, "walking")
		pass

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	if input_dir.x == 0.0 && input_dir.y == 0.0:
		Transitioned.emit(self, "walking")
		pass
