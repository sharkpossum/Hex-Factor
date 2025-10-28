extends PanelContainer
class_name Item_Slot

var item: Item
var assigned_slot: int
var source_inventory: Item_Inventory

var empty_slot_sprite: Texture2D = preload("res://scenes/ui/icon.svg")

signal HoveringSlot

var label_format = "%s (%s)"

func update_slot():
	item = source_inventory.get_item(assigned_slot)
	set_item(item)

func set_item(item: Item):
	if item:
		var label_text = label_format % [item.item_name, item.item_amount]
		
		%ItemLabel.text = label_text
		if item.ui_sprite:
			%ItemSprite.texture = item.ui_sprite
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		%ItemLabel.text = ""
		%ItemSprite.texture = empty_slot_sprite
		mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass

func set_inventory(inventory: Item_Inventory):
	source_inventory = inventory

func set_slot(slot: int):
	assigned_slot = slot
	
func _on_mouse_entered() -> void:
	HoveringSlot.emit(self)

func _on_mouse_exited() -> void:
	HoveringSlot.emit(null)
