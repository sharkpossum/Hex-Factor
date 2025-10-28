extends Control

@onready var player_stats: Player_Stats = %PlayerStats

var hotbar_item_slots: Dictionary[int, Item_Slot]

@onready var selector: ColorRect = %Selector

var inventory: Item_Inventory

var hotbar_items: Dictionary[int, Item]

func _ready() -> void:
	hotbar_item_slots[0] = %Item_Slot_0
	hotbar_item_slots[1] = %Item_Slot_1
	hotbar_item_slots[2] = %Item_Slot_2
	hotbar_item_slots[3] = %Item_Slot_3

func _on_player_ready() -> void:
	player_stats.FocusSlotChanged.connect(change_hotbar_highlight)
	
	for c in player_stats.GET_PLAYER().get_meta("components"):
		if c is Inventory_Component:
			inventory = c.get_inventory()
			c.get_inventory_update_signal().connect(update_hotbar_items)
		
	update_hotbar_items()

func change_hotbar_highlight(slot: int):
	selector.reparent(hotbar_item_slots[slot].get_parent(), false)
	pass

func update_hotbar_items():
	for i in range(player_stats.HOTBAR_SLOT_CAPACITY):
		var item = inventory.get_item(i)
		hotbar_item_slots[i].set_item(item)
