class_name PlayerMovementState
extends NodeState

var PLAYER: Player
var ANIMATION: AnimationPlayer

func _ready():
    await owner.ready
    PLAYER = owner as Player
    ANIMATION = PLAYER.ANIMATION_PLAYER
