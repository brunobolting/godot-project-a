class_name HealthComponent
extends Node

signal died

@export var MAX_HEALTH: float = 100.0

var _current_health: float

func _ready():
	_current_health = MAX_HEALTH

func take_damage(damage: float) -> void:
	_current_health = max(_current_health - damage, 0)
	print(owner.name, "Health: ", _current_health)
	Callable(_check_death).call_deferred()

func _check_death() -> void:
	if _current_health == 0:
		died.emit()
		owner.queue_free()
