extends Node3D

class_name Player_Head

@onready var player_body: CharacterBody3D = %PlayerBody
@onready var player_camera: Camera3D = %PlayerCamera

# Head bobbing
@export var BOB_FREQ : float = 3
@export var BOB_AMP : float = 0.05

var bobTime : float = 0.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	animate_head(delta)
	pass

func animate_head(delta: float):
	bobTime += delta * player_body.velocity.length() * float(player_body.is_on_floor())
	
	var bobOffset = Vector3.ZERO;
	bobOffset.y = sin(bobTime * BOB_FREQ) * BOB_AMP
	bobOffset.x = sin(bobTime * BOB_FREQ / 2) * BOB_AMP

	player_camera.transform.origin = bobOffset
	pass
