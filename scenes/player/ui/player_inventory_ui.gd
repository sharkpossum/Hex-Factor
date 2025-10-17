extends Control

class_name player_inventory_ui

var item_box_scene = preload("res://scenes/ui/item_box.tscn")

var items: Item_Inventory

func set_data(inventory: Item_Inventory):
	for i in inventory.capacity:
		var box = item_box_scene.instantiate()
		if inventory.get_item(i) != null:
			box.set_data(i, inventory.get_item(i))

		%PlayerInventoryGrid.add_child(box)
