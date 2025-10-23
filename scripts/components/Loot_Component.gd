extends On_Death_Component

class_name Loot_Component

# TODO: Replace with loot table once Item Manager overhaul is complete.
@export var item: PackedScene

func on_death():
	super.on_death()
	
	var spawn_position = component_owner.global_position
	spawn_position.y += 0.3
	
	ItemManager.spawn_object(item, spawn_position)
	component_owner.queue_free()
