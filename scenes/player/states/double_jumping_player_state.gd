class_name DoubleJumpingPlayerState
extends PlayerMovementState

@export var SPEED: float = 6
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var JUMP_VELOCITY: float = 5.0
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLIER: float = 0.85

func enter(_previousState) -> void:
    PLAYER.velocity.y = JUMP_VELOCITY
    ANIMATION.pause()

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED * INPUT_MULTIPLIER, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)

    if PLAYER.is_on_floor():
        ANIMATION.play("JumpEnd")
        transition.emit(NodeStateMachine.JUMPING_STATE)

