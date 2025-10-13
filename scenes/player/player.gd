extends CharacterBody3D

@export var config: Player_Config
@export var stats: Player_Stats

# Head bobbing
@export var BOB_FREQ : float = 2.0
@export var BOB_AMP : float = 0.06
var bobTime: float = 0.0

@onready var head = %Head
@onready var playerCam = %PlayerCamera

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(event.relative.x * -1 * config.MOUSE_SENSITIVITY)
		playerCam.rotate_x(event.relative.y * -1 * config.MOUSE_SENSITIVITY)
		playerCam.rotation.x = clamp(playerCam.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		pass
	pass
	
func _head_bob(delta: float, velocity: Vector3):
	bobTime += delta * velocity.length() * float(is_on_floor())
	var bobPos = Vector3.ZERO;
	bobPos.y = sin(bobTime * BOB_FREQ) * BOB_AMP
	bobPos.x = sin(bobTime * BOB_FREQ / 2) * BOB_AMP
	head.transform.origin = bobPos
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = stats.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	# Set direction basis to head direction.
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stats.SPEED
		velocity.z = direction.z * stats.SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
	_head_bob(delta, velocity)
