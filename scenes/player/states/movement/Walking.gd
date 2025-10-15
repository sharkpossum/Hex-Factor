extends Player_Movement_State

func Update(delta):
	super.Update(delta)
	
	if Input.is_action_just_pressed("sprint"):
		Transitioned.emit(self, "sprinting")
	
	if Input.is_action_just_pressed("crouch"):
		Transitioned.emit(self, "crouching")
