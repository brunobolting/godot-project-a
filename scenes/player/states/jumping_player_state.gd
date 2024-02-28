class_name JumpingPlayerState
extends PlayerMovementState

@export var SPEED: float = 6.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var JUMP_VELOCITY: float = 4.5
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLIER: float = 0.85

func enter(_previousState) -> void:
    PLAYER.velocity.y += JUMP_VELOCITY
    ANIMATION.play("JumpStart")

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED * INPUT_MULTIPLIER, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_just_released("jump"):
        if PLAYER.velocity.y > 0:
            PLAYER.velocity.y = PLAYER.velocity.y * 0.5

    if Input.is_action_just_pressed("jump") and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.DOUBLE_JUMPING_STATE)

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)

    if PLAYER.is_on_floor():
        ANIMATION.play("JumpEnd")
        transition.emit(NodeStateMachine.IDLE_STATE)
