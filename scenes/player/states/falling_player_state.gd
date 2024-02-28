class_name FallingPlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25

var previusState: NodeState

func enter(previousState: NodeState) -> void:
    self.previusState = previousState
    ANIMATION.pause()

func update(delta: float):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_just_pressed("jump") and previusState.name == NodeStateMachine.JUMPING_STATE:
        transition.emit(NodeStateMachine.DOUBLE_JUMPING_STATE)

    if PLAYER.is_on_floor():
        ANIMATION.play("JumpEnd")
        transition.emit(NodeStateMachine.IDLE_STATE)


