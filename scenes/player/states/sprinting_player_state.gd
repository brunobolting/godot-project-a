class_name SprintingPlayerState
extends PlayerMovementState

@export var SPEED: float = 7.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var TOP_ANIM_SPEED: float = 2.2

func enter(_previousState) -> void:
    if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
        await ANIMATION.animation_finished
        ANIMATION.play("Sprint", 0.5, 1.0)
    else:
        ANIMATION.play("Sprint", 0.5, 1.0)


func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    _set_animation_speed(PLAYER.velocity.length())

    if Input.is_action_just_released("sprint") or PLAYER.velocity.length() == 0:
        transition.emit(NodeStateMachine.IDLE_STATE)

    if Input.is_action_just_pressed("crouch") and PLAYER.velocity.length() >= 5.5:
        transition.emit(NodeStateMachine.SLIDING_STATE)

    if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.JUMPING_STATE)

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)

func _set_animation_speed(speed: float) -> void:
    var alpha = remap(speed, 0.0, SPEED, 0.0, 1.0)
    ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)


