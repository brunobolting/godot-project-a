class_name CrouchingPlayerState
extends PlayerMovementState

@export var SPEED: float = 3.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export_range(5, 10, 0.1) var CROUCH_SPEED: float = 7.0

@onready var CROUCH_SHAPECAST: ShapeCast3D = %ShapeCast3D

func enter() -> void:
    ANIMATION.play("Crouch", -1, CROUCH_SPEED)

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_just_released("crouch"):
        _uncrouch()

func _uncrouch():
    if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_pressed("crouch") == false:
        ANIMATION.play("Crouch", -1, -CROUCH_SPEED * 1.5, true)
        if ANIMATION.is_playing():
            await ANIMATION.animation_finished
        transition.emit("IdlePlayerState")
    elif CROUCH_SHAPECAST.is_colliding():
        await get_tree().create_timer(0.1).timeout
        _uncrouch()
