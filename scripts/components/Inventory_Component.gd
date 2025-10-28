extends Component

class_name Inventory_Component

@export var inventory: Item_Inventory

func get_inventory() -> Item_Inventory:
	return inventory

func get_inventory_update_signal	() -> Signal:
	return inventory.InventoryUpdated
