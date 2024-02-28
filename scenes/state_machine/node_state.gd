class_name NodeState
extends Node

signal transition(newStateName: StringName)

func enter(_previousState: NodeState) -> void:
    pass

func exit() -> void:
    pass

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass
