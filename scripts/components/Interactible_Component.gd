extends Node

class_name Interactible_Component

func interact():
	get_parent().queue_free()
	pass
