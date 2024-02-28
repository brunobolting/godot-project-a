class_name SlidingPlayerState
extends PlayerMovementState

@export var SPEED: float = 6.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var TILT_AMOUNT: float = 0.09
@export_range(1, 6, 0.1) var SLIDE_ANIMATION_SPEED: float = 4.0

@onready var CROUCH_SHAPECAST: ShapeCast3D = %ShapeCast3D

const _SPEED_ANIM_TRACK: int = 5;
const _CAMERA_ROTATION_ANIM_TRACK: int = 3;

func enter(_previousState) -> void:
    _set_tilt(PLAYER._current_rotation)
    ANIMATION.get_animation("Sliding").track_set_key_value(_SPEED_ANIM_TRACK, 0, PLAYER.velocity.length())
    ANIMATION.speed_scale = 1.0
    ANIMATION.play("Sliding", -1, SLIDE_ANIMATION_SPEED)


func update(delta):
    PLAYER.update_gravity(delta)
    # PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()


func _set_tilt(playerRotation: float) -> void:
    var tilt = Vector3.ZERO
    tilt.z = clamp(TILT_AMOUNT * playerRotation, -0.1, 0.1)
    if tilt.z == 0.0:
        tilt.z = 0.05
    ANIMATION.get_animation("Sliding").track_set_key_value(_CAMERA_ROTATION_ANIM_TRACK, 1, tilt)
    ANIMATION.get_animation("Sliding").track_set_key_value(_CAMERA_ROTATION_ANIM_TRACK, 2, tilt)

func finish():
    transition.emit(NodeStateMachine.CROUCHING_STATE)
