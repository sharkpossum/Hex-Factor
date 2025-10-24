extends Resource

class_name Drop_Table

@export var guaranteed_drops : Array[String] = []
@export var has_random_drops: bool = false
@export var drop_table: Dictionary[int, String]
@export var rolls: int = 1

func get_loot() -> Array[String]:
	var drops : Array[String] = []
	
	for d in guaranteed_drops:
		drops.append(d)
	
	if has_random_drops:
		for i in range(rolls):
			drops.append(roll())
	
	return drops


func roll() -> String:
	var total_chance = 0
	var rng = RandomNumberGenerator.new()

	for d in drop_table:
		total_chance += d

	var result = rng.randi_range(1, total_chance)
	
	for drop in drop_table:
		if result - drop <= 0:
			return drop_table[drop]
		result -= drop
	return "ERROR"
