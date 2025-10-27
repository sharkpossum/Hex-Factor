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
# First creates a stack where possible, if not, adds the item to the empty slot.
func add_item(item: Item):
		var empty_slot = -1
		for slot in range(capacity):
			if slots.has(slot):
				var contained_item = slots[slot]
				
				if contained_item.item_id == item.item_id:
					if contained_item.is_stackable:
						var difference = contained_item.stack_capacity - (contained_item.item_amount + item.item_amount) 
						if difference < 0:
							item.item_amount = -difference
							contained_item.item_amount = contained_item.stack_capacity
						else:
							contained_item.item_amount += item.item_amount
							return 0
			
			else:
				if empty_slot == -1:
					empty_slot = slot
		
		if empty_slot != -1:
			slots[empty_slot] = item
			return 0
		return item.item_amount
		
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
