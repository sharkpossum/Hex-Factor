extends Player_In_Menu_State

var inventory_menu = preload("res://scenes/player/ui/player_inventory_UI.tscn")
var menu : player_inventory_ui

func Enter():
	super.Enter()
	
	menu = inventory_menu.instantiate()
	for c in player.get_meta("components"):
		if c is Inventory_Component:
			menu.set_data(c.get_inventory())
	
	GUI.add_child(menu)
	
func Exit():
	menu.queue_free()
	super.Exit()
	pass

func Update(_delta: float):
	if Input.is_action_just_pressed("inventory"):
		Transitioned.emit(self, "neutral")
