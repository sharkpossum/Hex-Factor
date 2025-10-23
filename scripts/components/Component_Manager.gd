extends Node

class_name Component_Manager

var components: Array[Component] = []

func _ready() -> void:
	for child in get_children():
		if child is Component:
			components.append(child)
			child.set_component_owner(self.owner)
	for component in components:
		component.set_owner_components(components)
		component.connect_component()
	
	owner.set_meta("components", components)
