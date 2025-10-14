extends Node3D

signal State_Parent_Ready

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	emit_signal("State_Parent_Ready")
	pass
