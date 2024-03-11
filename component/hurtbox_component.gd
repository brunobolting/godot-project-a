class_name HurtboxComponent
extends Area3D

@export var health_component: HealthComponent

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitboxComponent):
	if hitbox == null:
		return

	if health_component == null:
		return

	# print("hurtbox: ", self.owner, " hitbox: ", hitbox.owner)

	if self.owner.is_in_group("player"):
		return

	health_component.take_damage(hitbox.DAMAGE)
