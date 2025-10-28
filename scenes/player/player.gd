extends Node3D

class_name Player

@onready var player_stats = %PlayerStats

signal State_Parent_Ready

func _ready():
	player_stats.player = self
	emit_signal("State_Parent_Ready")
	pass

func get_stats() -> Player_Stats:
	return player_stats
