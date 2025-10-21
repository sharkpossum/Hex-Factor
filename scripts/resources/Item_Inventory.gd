extends Resource

class_name Item_Inventory

var slots: Dictionary[int, Item] = {}
var capacity: int = 24

# Returns the item of the specified slot.
func get_item(slot: int) -> Item:
	if slots.has(slot):
		return slots[slot]
	else:
		return null

func is_full() -> bool:
	if slots.size() >= capacity:
		return true
	return false

func get_key(item: Item) -> int:
	return slots.find_key(item)

# Returns all items from the inventory.
func get_items():
	var items: Array[Item] = []
	for slot in slots:
		items.append(slots[slot])
	
	return items
	
# Attempts to add an item if there is space.
func add_item(item: Item):
	for i in range(capacity):
		if !slots.has(i):
			slots[i] = item
			break

# Attempts to set an item. If the slot is taken, return the current item.
func set_item(slot: int, item: Item):
	if slots.has(slot):
		var old_item = slots[slot]
		slots[slot] = item
		return old_item
	else:
		slots[slot] = item
		return null
		
func delete_item(slot: int):
	slots.erase(slot)
	pass

func swap_item(slotA: int, inventoryA: Item_Inventory, slotB: int, inventoryB: Item_Inventory):
	var to_swap = inventoryB.set_item(slotB, inventoryA.get_item(slotA))
	inventoryA.set_item(slotA, to_swap)
