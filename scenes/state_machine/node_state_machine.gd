class_name NodeStateMachine
extends Node

@export var CURRENT_STATE: NodeState
@export var PLAYER : Player
var states: Dictionary = {}

func _ready():
	if CURRENT_STATE == null:
		push_warning("No current state set")
		return

	if PLAYER == null:
		push_warning("No character set")
		return

	for child in get_children():
		if child is NodeState:
			states[child.name] = child
			child.connect("transition", on_child_transition)
		else:
			push_warning("State machine contains incompatible child node")

	await owner.ready
	CURRENT_STATE.enter()

func _process(delta):
	CURRENT_STATE.update(delta)
	Debug.add_property("Current State", CURRENT_STATE.name, 1)

func _physics_process(delta):
	CURRENT_STATE.physics_update(delta)

func on_child_transition(newStateName: StringName) -> void:
	var newState = states.get(newStateName)
	if newState != null:
		if newState != CURRENT_STATE:
			CURRENT_STATE.exit()
			CURRENT_STATE = newState
			CURRENT_STATE.enter()
	else:
		push_warning("State does not exist in state machine")