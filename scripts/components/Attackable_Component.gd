extends Component

class_name Attackable_Component

@export var hitbox: CollisionShape3D
@export var mesh: Node3D
@export var animation_player: AnimationPlayer

signal Attacked

func connect_component():
	for c in get_owner_components():
		if c is Health_Component:
			Attacked.connect(c.take_damage)
			
func interact_with_source(source: Node):
	on_hit(25, source)
	pass

func on_hit(damage: float, source: Node):
	Attacked.emit(damage, source)
	
	if animation_player:
		animation_player.play("on_hit")
