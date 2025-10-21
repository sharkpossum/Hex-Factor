extends Node

# Item and resource spawning management class to give items a collective parent and for logging.
class_name Item_Manager

func spawn_object(packed_scene: PackedScene, global_position: Vector3):
	var to_spawn: Node3D = packed_scene.instantiate()
	to_spawn.transform.origin = Vector3.ZERO
	to_spawn.position = global_position
	
	var format_print = "Spawning %s, at %s."
	var print_output = format_print % [to_spawn.name, global_position]
	
	print(print_output)
	
	add_child(to_spawn)
