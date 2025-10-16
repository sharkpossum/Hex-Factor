extends Interactible_Component

class_name Collect_Component

# Passes the player data of collector.
func interact_with_source(player: Node):
	super.interact_with_source(player)
	
	var item_scene = self.owner.duplicate()
	player.get_stats().INVENTORY.add_item(item_scene)
	self.owner.queue_free()
