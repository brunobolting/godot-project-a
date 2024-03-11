class_name HitboxComponent
extends Area3D

@export var NAME: StringName
@export var DAMAGE: float = 30.0

func _init():
	collision_layer = 2
	collision_mask = 0
