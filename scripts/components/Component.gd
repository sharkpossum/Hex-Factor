extends Node

class_name Component

var component_owner: Node3D

func set_component_owner(component_owner: Node3D):
	self.component_owner = component_owner

func get_component_owner() -> Node3D:
	return component_owner
