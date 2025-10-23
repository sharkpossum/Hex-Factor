# Temporarily made interactible for debugging.
extends Interactible_Component

class_name Pokeable_Component

@export var hitbox: CollisionShape3D
@export var mesh: Node3D
@export var animation_player: AnimationPlayer
@export var poke_damage: float = 1.0

signal Poked

func connect_component():
	for c in get_owner_components():
		if c is Health_Component:
			Poked.connect(c.take_damage)
			
func interact_with_source(source: Node):
	on_hit(poke_damage, source)
	pass

func on_hit(damage: float, source: Node):
	Poked.emit(damage, source)
	
	if animation_player:
		animation_player.play("on_hit")
