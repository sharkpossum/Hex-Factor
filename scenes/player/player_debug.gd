extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Debug tool to quit the game when pressing the kill switch.
func _input(event: InputEvent):
	if event.is_action_pressed("kill"):
		get_tree().quit()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
