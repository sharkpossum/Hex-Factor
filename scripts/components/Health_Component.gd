extends Component

class_name Health_Component

@export var health: float

signal OnDeath
signal HealthChanged

func connect_component():
	for c in get_owner_components():
		if c is On_Death_Component:
			OnDeath.connect(c.on_death)

func take_damage(amount: float, source: Node):
	health -= amount
	HealthChanged.emit(health)
	if health <= 0:
		OnDeath.emit()
