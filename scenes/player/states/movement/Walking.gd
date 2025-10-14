extends Player_Movement_State

func Update(delta):
	if Input.is_action_just_pressed("sprint"):
		Transitioned.emit(self, "sprinting")
		pass
	pass
