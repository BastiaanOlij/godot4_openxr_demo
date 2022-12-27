@tool
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var origin_node = $XROrigin3D
@onready var camera_node = $XROrigin3D/XRCamera3D
@onready var head_position_node = $XROrigin3D/XRCamera3D/HeadPosition
@onready var blackout_node = $XROrigin3D/XRCamera3D/BlackOut

@export var eye_offset = 0.1:
	set(new_value):
		eye_offset = new_value
		if is_inside_tree():
			_update_head_position()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _update_head_position():
	head_position_node.transform.origin.z = eye_offset
	if Engine.is_editor_hint():
		camera_node.transform.origin.z = -eye_offset

func _ready():
	_update_head_position()

func _process_on_physical_movement(delta) -> bool:
	# Remember our velocity we're not applying that on physical movement
	var org_velocity = velocity

	# Start by rotating the player to face the same way our real player is
	var camera_basis : Basis = origin_node.transform.basis * camera_node.transform.basis
	var forward : Vector2 = Vector2(camera_basis.z.x, camera_basis.z.z)
	var angle : float = forward.angle_to(Vector2(0.0, 1.0))
	# print(angle)
	
	transform.basis = transform.basis.rotated(Vector3.UP, angle)
	origin_node.transform = Transform3D().rotated(Vector3.UP, -angle) * origin_node.transform

	# Now apply movement, first move our player body to the right location
	var org_player_body : Vector3 = global_transform.origin
	var player_body_location : Vector3 = origin_node.transform * camera_node.transform * head_position_node.transform.origin
	player_body_location.y = 0.0
	player_body_location = global_transform * player_body_location

	velocity = (player_body_location - org_player_body) / delta
	move_and_slide()

	# Now move our XROrigin back
	var delta_movement = org_player_body - global_transform.origin
	delta_movement.y = 0.0
	$XROrigin3D.global_transform.origin += delta_movement

	# Return our value
	velocity = org_velocity

	# Adjust our fade
	var distance : float = (player_body_location - org_player_body).length()
	var colliding = distance > 0.01
	if colliding:
		var material : ShaderMaterial = blackout_node.get_surface_override_material(0)
		if material:
			var fade : float = clamp(distance * 10.0, 0.0, 1.0)

			material.set_shader_parameter("fade", fade)
		blackout_node.visible = true
	else:
		blackout_node.visible = false

	return colliding

func _process_on_player_input(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _physics_process(delta):
	# Don't do this in editor
	if Engine.is_editor_hint():
		return

	var colliding = _process_on_physical_movement(delta)
	if !colliding:
		_process_on_player_input(delta)
