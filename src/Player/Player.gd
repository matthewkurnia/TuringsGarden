extends KinematicBody2D


const NORMAL = Vector2(0, -1)

export var friction = 0.1
export var max_speed = 600.0
export var acceleration = 100.0
export var jump_strength = 1000.0
export var gravity = 30.0
export var terminal_velo = 800.0

var rotation_transform = Transform2D.IDENTITY
var rotation_transform_inv = Transform2D.IDENTITY.inverse()
var velo = Vector2()

onready var state_machine = $StateMachine


func _ready():
	PlayerCamera.set_target(self)


func _physics_process(delta):
	var tmp_velo = state_machine.update_movement(rotation_transform_inv * velo)
	tmp_velo.x = lerp(tmp_velo.x, 0, friction)
	velo = move_and_slide(rotation_transform * tmp_velo, rotation_transform * NORMAL)


func rotate_transform(amount : float) -> void:
	rotation_transform = rotation_transform.rotated(amount)
	rotation_transform_inv = rotation_transform.inverse()
