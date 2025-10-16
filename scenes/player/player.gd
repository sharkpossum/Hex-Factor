extends Node3D

signal State_Parent_Ready

func _ready():
	emit_signal("State_Parent_Ready")
	pass
