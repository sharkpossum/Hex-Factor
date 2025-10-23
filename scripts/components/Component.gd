extends Node

class_name Component

var component_owner: Node3D
var owner_components: Array[Component] = []

func set_component_owner(component_owner: Node3D):
	self.component_owner = component_owner

func get_component_owner() -> Node3D:
	return component_owner
	
func set_owner_components(components: Array[Component]) -> void:
	owner_components = components
	pass

func get_owner_components() -> Array[Component]:
	return owner_components

func connect_component() -> void:
	pass
