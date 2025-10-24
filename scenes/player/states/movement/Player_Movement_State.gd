extends State

class_name Player_Movement_State

# State properties
@export var state_speed = 5.0
@export var state_height = 1.40

var height_progress := 0.0
var height_adjust_step := 0.0

@onready var player_body: CharacterBody3D = %PlayerBody
@onready var player_stats: Player_Stats = %PlayerStats
@onready var player_head: Node3D = %Head
@onready var player_camera = %PlayerCamera


var player_head_origin := Vector3.ZERO

func Enter():
	height_progress = 0.0
	
	player_stats.SPEED = state_speed
	height_adjust_step = player_stats.SPEED * 4
	pass
	
func Update(delta: float):
	handle_height_change(delta)
	pass
	
func Physics_Update(delta: float):
	Move(delta)
	pass

func handle_height_change(delta: float):
	height_progress = lerp(player_stats.HEIGHT, state_height, delta * height_adjust_step)
	
	player_stats.HEIGHT = snapped(height_progress, 0.001)
	player_head.position.y = player_stats.HEIGHT / 2

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
	if direction && player_stats.CAN_MOVE:
		player_body.velocity.x = direction.x * player_stats.SPEED
		player_body.velocity.z = direction.z * player_stats.SPEED
	else:
		player_body.velocity.x = 0
		player_body.velocity.z = 0

	player_body.move_and_slide()

# First Person controls
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && player_stats.CAN_LOOK:
		player_head.rotate_y(event.relative.x * -1 * player_stats.CONFIG.MOUSE_SENSITIVITY)
		player_camera.rotate_x(event.relative.y * -1 * player_stats.CONFIG.MOUSE_SENSITIVITY)
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		pass
	pass
	
