extends RigidBody3D
class_name Item

# UI
@export var ui_sprite: Texture2D

# Stats
@export var item_name: String = ""
@export var description: String = "Description"
@export var weight: int = 1
@export var stack_size: int = 16
@export var flavour_text: String = "Flavourful."
