class_name IdlePlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25

func enter() -> void:
    ANIMATION.pause()

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_pressed("crouch") and PLAYER.is_on_floor():
        transition.emit("CrouchingPlayerState")

    if PLAYER.velocity.length() > 0.0 and PLAYER.is_on_floor():
        transition.emit("WalkingPlayerState")


