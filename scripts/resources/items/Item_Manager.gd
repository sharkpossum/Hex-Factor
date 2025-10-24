extends Node

# Item and resource spawning management class to give items a collective parent and for logging.
class_name Item_Manager

@export var item_registries: Array[Item_Registry] = []

func spawn_object_by_id(id: String, global_position: Vector3):
	for r in item_registries:
		if r.registry.has(id):
			spawn(r.registry[id], global_position)
			
func spawn_objects_by_id(ids: Array[String], global_position: Vector3):
	for i in ids:
		spawn_object_by_id(i, global_position)
	pass

func spawn_object(packed_scene: PackedScene, global_position: Vector3):
	spawn(packed_scene, global_position)

func spawn(packed_scene: PackedScene, global_position: Vector3):
	var to_spawn: Node3D = packed_scene.instantiate()
	to_spawn.position = global_position
		
	var format_print = "Spawning %s, at %s."
	var print_output = format_print % [to_spawn.name, global_position]
	
	print(print_output)
	add_child(to_spawn)
	pass
