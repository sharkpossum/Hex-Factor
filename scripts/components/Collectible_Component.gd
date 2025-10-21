extends Interactible_Component

class_name Collectible_Component

var item_scene: PackedScene
var item_instance: Item

func _ready() -> void:
	item_scene = PackedScene.new()

# Passes the player data of collector.
func interact_with_source(player: Node):
	
	for c in player.get_meta("components"):
		if c is Inventory_Component:
			if !c.get_inventory().is_full():
				item_scene.pack(component_owner)
				c.get_inventory().add_item(item_scene.instantiate())
				component_owner.queue_free()
			
