extends Node

class_name Component_Manager

var components: Array[Component] = []

func _ready() -> void:
	for child in get_children():
		if child is Component:
			components.append(child)
	
	owner.set_meta("components", components)
