extends Player_Movement_State

@export var TOGGLE_CROUCH: bool = true

func Update(delta: float):
	super.Update(delta)

	if !TOGGLE_CROUCH:
		if Input.is_action_just_released("crouch"):
			Transitioned.emit(self, "walking")
			
	else:
		if Input.is_action_just_pressed("crouch"):
			Transitioned.emit(self, "walking")
	
	if Input.is_action_just_pressed("sprint"):
		Transitioned.emit(self, "sprinting")
