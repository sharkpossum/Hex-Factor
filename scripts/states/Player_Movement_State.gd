extends State

class_name Player_Movement_State

# Head bobbing
@export var state_speed = 5.0
@export var BOB_FREQ : float = 2.0
@export var BOB_AMP : float = 0.06
var bobTime: float = 0.0

@onready var player_body: CharacterBody3D = %PlayerBody
@onready var player_stats = %PlayerStats
@onready var player_head = %Head
@onready var player_camera = %PlayerCamera

# Move this into a config global later.
var MOUSE_SENSITIVITY = 0.003

func Move(delta):
	if not player_body.is_on_floor():
		player_body.velocity += player_body.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and player_body.is_on_floor():
		player_body.velocity.y = player_stats.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	# Set direction basis to head direction.
	var direction = (player_head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player_body.velocity.x = direction.x * player_stats.SPEED
		player_body.velocity.z = direction.z * player_stats.SPEED
	else:
		player_body.velocity.x = 0
		player_body.velocity.z = 0

	player_body.move_and_slide()
	head_bob(delta, player_body.velocity)
	

func head_bob(delta: float, velocity: Vector3):
	bobTime += delta * player_body.velocity.length() * float(player_body.is_on_floor())
	var bobPos = Vector3.ZERO;
	bobPos.y = sin(bobTime * BOB_FREQ) * BOB_AMP
	bobPos.x = sin(bobTime * BOB_FREQ / 2) * BOB_AMP
	player_head.transform.origin = bobPos
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player_head.rotate_y(event.relative.x * -1 * MOUSE_SENSITIVITY)
		player_camera.rotate_x(event.relative.y * -1 * MOUSE_SENSITIVITY)
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		pass
	pass
	
func Physics_Update(delta: float):
	Move(delta)
	pass
