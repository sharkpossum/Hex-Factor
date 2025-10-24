extends On_Death_Component

class_name Loot_Component

@export var drop_table: Drop_Table

func on_death():
	super.on_death()
	
	var spawn_position = component_owner.global_position
	spawn_position.y += 0.3
	
	var drops = drop_table.get_loot()
	component_owner.queue_free()
	ItemManager.spawn_objects_by_id(drops, spawn_position)
