class_name SwordWeapon
extends Node3D

@export var ANIMATION_PLAYER: AnimationPlayer

@onready var comboCounter: int = 0


func _process(_delta):
    if Input.is_action_just_pressed("parry"):
            ANIMATION_PLAYER.play("sword_parry_01")

    if Input.is_action_pressed("attack"):
        if ANIMATION_PLAYER.is_playing() and ANIMATION_PLAYER.current_animation != "sword_idle":
            await ANIMATION_PLAYER.animation_finished
        if comboCounter == 0:
            ANIMATION_PLAYER.play("sword_attack_01")
            comboCounter += 1
        elif comboCounter == 1:
            ANIMATION_PLAYER.play("sword_attack_03")
            comboCounter += 1
        elif comboCounter == 2:
            ANIMATION_PLAYER.play("sword_attack_02")
            comboCounter += 1
        elif comboCounter == 3:
            ANIMATION_PLAYER.play("sword_attack_04")
            comboCounter = 0
    else:
        if ANIMATION_PLAYER.is_playing():
            await ANIMATION_PLAYER.animation_finished
            ANIMATION_PLAYER.play("sword_idle")



