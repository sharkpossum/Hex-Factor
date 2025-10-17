extends Panel
class_name item_box

var item: Item
var slot: int

func set_data(new_slot:int, new_item: Node3D):
	item = new_item
	slot = new_slot
	$ItemNameLabel.text = item.name
