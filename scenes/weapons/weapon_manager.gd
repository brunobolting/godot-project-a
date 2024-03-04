@tool

class_name WeaponManager
extends Node3D

@export var WEAPON_TYPE: Weapon:
    set(value):
        WEAPON_TYPE = value
        if Engine.is_editor_hint():
            load_weapon()

@onready var weaponMesh: MeshInstance3D = %WeaponMesh
@onready var weaponShadow: MeshInstance3D = %WeaponShadow

func _ready() -> void:
    load_weapon()


func load_weapon() -> void:
    weaponMesh.mesh = WEAPON_TYPE.mesh
    position = WEAPON_TYPE.position
    rotation_degrees = WEAPON_TYPE.rotation
    scale = WEAPON_TYPE.scale
    weaponShadow.visible = WEAPON_TYPE.shadow


# @export var ANIMATION: AnimationPlayer

# func _physics_process(_delta):
#     if Input.is_action_just_pressed("attack"):
#         if ANIMATION.current_animation != "crowbar_attack":
#             ANIMATION.play("crowbar_attack")
#             ANIMATION.queue("crowbar_idle")

