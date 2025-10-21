extends RigidBody3D
class_name Item

# UI
@export var ui_sprite: Texture2D

# Stats
@export var description: String
@export var weight: int
@export var item_name: String

func _ready() -> void:
	item_name = self.name
	pass
