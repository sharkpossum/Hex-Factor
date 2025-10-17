extends Interactible_Component

class_name Collectible_Component

# Passes the player data of collector.
func interact_with_source(player: Node):
	var item_scene = self.owner.duplicate()
	
	for c in player.get_meta("components"):
		if c is Inventory_Component:
			c.get_inventory().add_item(item_scene)
	
	self.owner.queue_free()
