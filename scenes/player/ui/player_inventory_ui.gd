extends Control

class_name player_inventory_ui

var item_slot_scene = preload("res://scenes/ui/Item_Slot.tscn")

var inventory_component: Inventory_Component
var GUI: Player_GUI

# Held item data for drag and drop between inventories.
var held_item_slot: int
var held_item_inventory: Item_Inventory
var is_holding: bool = false
var focused_slot: Item_Slot

# UI element for drag-and-drop.
@onready var drag_icon = %DragIcon
@onready var drag_texture = %DragTexture
var drag_size_offset: Vector2

# Distance item is dropped from player head.
var drop_distance: float = 2.0

signal RedrawSlots

func _physics_process(_delta: float) -> void:
	if !is_holding && focused_slot:
		if Input.is_action_just_pressed("select"):
			if focused_slot.item:
				hold_item(focused_slot.assigned_slot, focused_slot.source_inventory)
	
	if is_holding:
		drag_icon.position = get_viewport().get_mouse_position() - drag_size_offset
		if Input.is_action_just_released("select"):
			if focused_slot:
				drop_item_in_slot(focused_slot.assigned_slot, focused_slot.source_inventory)
			else:
				drop_item()

func on_focus_slot_change(focused_slot: Item_Slot):
	self.focused_slot = focused_slot

func open_inventory(inventory_component: Inventory_Component, GUI: Player_GUI):
	self.GUI = GUI
	self.inventory_component = inventory_component

	for i in inventory_component.get_inventory().capacity:
		
		var box : Item_Slot = item_slot_scene.instantiate()
		box.set_inventory(inventory_component.get_inventory())
		box.set_slot(i)
		box.update_slot()
		box.HoveringSlot.connect(on_focus_slot_change)
		RedrawSlots.connect(box.update_slot)

		%PlayerInventoryGrid.add_child(box)
		
func hold_item(slot: int, inventory: Item_Inventory):
	held_item_slot = slot
	held_item_inventory = inventory
	
	drag_texture.texture = held_item_inventory.get_item(held_item_slot).ui_sprite
	drag_size_offset = drag_texture.size / 2
	
	drag_icon.visible = true
	is_holding = true
	
	RedrawSlots.emit()

func drop_item_in_slot(hovered_slot: int, hovered_inventory: Item_Inventory):
	if !hovered_inventory.get_item(hovered_slot):
		hovered_inventory.set_item(hovered_slot, held_item_inventory.get_item(held_item_slot))
		held_item_inventory.delete_item(held_item_slot)
	else:
		hovered_inventory.swap_item(held_item_slot, held_item_inventory, hovered_slot, hovered_inventory)
	
	RedrawSlots.emit()
	
	drag_icon.visible = false
	is_holding = false

func drop_item():
	var item_spawn: PackedScene = PackedScene.new()
	item_spawn.pack(held_item_inventory.get_item(held_item_slot))
	
	held_item_inventory.delete_item(held_item_slot)
	RedrawSlots.emit()
	
	var player: Player = inventory_component.get_component_owner()
	var head = player.get_stats().GET_PLAYER_HEAD()
	var from = head.global_position
	var to = from + head.global_transform.basis.z * -drop_distance
	
	var drop_position = to
	
	ItemManager.spawn_object(item_spawn, to)
	
	drag_icon.visible = false
	is_holding = false
