extends RigidBody3D
class_name Item

# UI
@export var ui_sprite: Texture2D

# Stats
@export var item_name: String = ""
@export var description: String = "Description"
@export var weight: int = 1
@export var stack_capacity: int = 16
@export var flavour_text: String = "Flavourful."

@export var item_id: String = ""
@export var is_stackable: bool = true
@export var item_amount: int = 0
