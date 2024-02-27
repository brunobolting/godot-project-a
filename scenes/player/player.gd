class_name Player
extends CharacterBody3D

# @export var TOGGLE_CROUCH: bool = false
@export var JUMP_VELOCITY: float = 4.5
# @export_range(5, 10, 0.1) var CROUCH_SPEED: float = 7.0
@export var MOUSE_SENSITIVITY: float = 0.5
@export_range(-70.0, -120.0, 0.5) var TILT_LOWER_LIMIT: float = -90.0
@export_range(70.0, 120.0, 0.5) var TILT_UPPER_LIMIT: float = 90.0
@export var CAMERA_CONTROLLER: Camera3D
@export var ANIMATION_PLAYER: AnimationPlayer

var _speed: float
var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3

var _is_crouching: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

    # _speed = SPEED_DEFAULT

    # ANIMATION_PLAYER.connect("animation_started", _on_animation_started)

    # CROUCH_SHAPECAST.add_exception(self)

func _input(event):
    if event.is_action_pressed("exit"):
        get_tree().quit()

    # if event.is_action_pressed("crouch") and is_on_floor() and TOGGLE_CROUCH:
    #     toggle_crouch()

    # if event.is_action_pressed("crouch") and _is_crouching == false and TOGGLE_CROUCH == false:
    #     # hold to crouch
    #     _crouch()
    # if event.is_action_released("crouch") and TOGGLE_CROUCH == false:
    #     if CROUCH_SHAPECAST.is_colliding() == false:
    #         _uncrouch()
    #     elif CROUCH_SHAPECAST.is_colliding() == true:
    #         _uncrouch_check()

func _unhandled_input(event):
    _mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
    if _mouse_input:
        _rotation_input = -event.relative.x * MOUSE_SENSITIVITY
        _tilt_input = -event.relative.y * MOUSE_SENSITIVITY


func _update_camera(delta):
    _mouse_rotation.x += _tilt_input * delta
    _mouse_rotation.x = clamp(_mouse_rotation.x, deg_to_rad(TILT_LOWER_LIMIT), deg_to_rad(TILT_UPPER_LIMIT))
    _mouse_rotation.y += _rotation_input * delta

    _player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
    _camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)

    CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
    CAMERA_CONTROLLER.rotation.z = 0.0

    global_transform.basis = Basis.from_euler(_player_rotation)

    _rotation_input = 0.0
    _tilt_input = 0.0


func _physics_process(delta):
    Debug.add_property("Velocity", "%.2f" % velocity.length(), 1)

    _update_camera(delta)

    # Handle jump.
    # if Input.is_action_just_pressed("jump") and is_on_floor() and _is_crouching == false:
    #     velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.


func update_gravity(_delta) -> void:
    velocity.y -= gravity * _delta

func update_input(speed: float, acceleration: float, deceleration: float) -> void:
    var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
        velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
    else:
        velocity.x = move_toward(velocity.x, 0, deceleration)
        velocity.z = move_toward(velocity.z, 0, deceleration)

func update_velocity() -> void:
    move_and_slide()

# func toggle_crouch():
#     if _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false:
#         _uncrouch()
#     elif _is_crouching == false:
#         _crouch()

# func _crouch():
#     ANIMATION_PLAYER.play("Crouch", 0, CROUCH_SPEED)
#     _set_movement_speed("crouching")

# func _uncrouch():
#     ANIMATION_PLAYER.play("Crouch", 0, -CROUCH_SPEED, true)
#     _set_movement_speed("default")

# func _uncrouch_check():
#     if not CROUCH_SHAPECAST.is_colliding():
#         _uncrouch()
#     if CROUCH_SHAPECAST.is_colliding():
#         await get_tree().create_timer(0.1).timeout
#         _uncrouch_check()

# func _on_animation_started(animation):
#     if animation == "Crouch":
#         _is_crouching = !_is_crouching

# func _set_movement_speed(state: String):
#     match state:
#         "default":
#             _speed = SPEED_DEFAULT
#         "crouching":
#             _speed = SPEED_CROUCH
