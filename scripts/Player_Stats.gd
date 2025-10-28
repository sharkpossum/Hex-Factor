extends Node

class_name Player_Stats

@export var SPEED = 5.0
@export var HEIGHT = 0.75
@export var JUMP_VELOCITY = 4.5
@export var CAN_MOVE: bool = true
@export var CAN_LOOK: bool = true

@export var CONFIG: Player_Config;

var player: Player

signal FocusSlotChanged
var FOCUSED_SLOT: int = 0
var HOTBAR_SLOT_CAPACITY: int = 4

func GET_PLAYER_POSITION() -> Vector3:
	return %PlayerBody.global_position

func GET_PLAYER_HEAD() -> Player_Head:
	return %Head
	
func GET_PLAYER() -> Player:
	return player

func SET_FOCUS_SLOT(slot: int):
	if FOCUSED_SLOT != slot:
		if slot > (HOTBAR_SLOT_CAPACITY - 1):
			FOCUSED_SLOT = 0
			pass
		elif slot < 0:
			FOCUSED_SLOT = (HOTBAR_SLOT_CAPACITY - 1)
		else:
			FOCUSED_SLOT = slot
		
		FocusSlotChanged.emit(FOCUSED_SLOT)
