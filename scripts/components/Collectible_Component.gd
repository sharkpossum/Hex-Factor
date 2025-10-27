extends Interactible_Component

class_name Collectible_Component

var item_scene: PackedScene

func _ready() -> void:
	item_scene = PackedScene.new()

# Passes the player data of collector.
func interact_with_source(player: Node):
	for c in player.get_meta("components"):
		if c is Inventory_Component:
			item_scene.pack(component_owner)
			owner.item_amount = c.get_inventory().add_item(item_scene.instantiate())
			
			if owner.item_amount < 1:
				owner.queue_free()
