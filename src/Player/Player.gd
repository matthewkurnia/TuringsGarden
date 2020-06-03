extends KinematicBody2D


const NORMAL = Vector2(0, -1)

export var friction = 0.1
export var max_speed = 600.0
export var acceleration = 100.0
export var jump_strength = 1000.0
export var gravity = 30.0
export var terminal_velo = 800.0
export var push_pull_velo = Vector2()

var apply_friction = true
var rotation_transform = Transform2D.IDENTITY
var rotation_transform_inv = Transform2D.IDENTITY.inverse()
var velo = Vector2()
var direction = 1

onready var state_machine = $StateMachine


func _physics_process(delta):
	var tmp_velo = state_machine.update_movement(rotation_transform_inv * velo)
	if apply_friction:
		tmp_velo.x = lerp(tmp_velo.x, 0, friction)
	velo = move_and_slide(rotation_transform * tmp_velo, rotation_transform * NORMAL)
	direction = sign(velo.x)


func change_state(state_name: String):
	$StateMachine.change_state(state_name)


func rotate_transform(amount: float) -> void:
	rotation_transform = rotation_transform.rotated(amount)
	rotation_transform_inv = rotation_transform.inverse()
