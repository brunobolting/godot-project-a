class_name HurtboxComponent
extends Area3D

@export var NAME: StringName
@export var HEALTH_COMPONENT: HealthComponent

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitboxComponent):
	if hitbox == null:
		return

	if HEALTH_COMPONENT == null:
		return


	if self.owner.is_in_group("player"):
		return

	# print("hurtbox: ", self.NAME, " hitbox: ", hitbox.NAME)

	HEALTH_COMPONENT.take_damage(hitbox.DAMAGE)
