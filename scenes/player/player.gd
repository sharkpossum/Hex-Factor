extends Node3D

@onready var player_stats = %PlayerStats

signal State_Parent_Ready

func _ready():
	emit_signal("State_Parent_Ready")
	pass

func get_stats() -> Node:
	return player_stats
