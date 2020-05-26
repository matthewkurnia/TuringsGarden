extends KinematicBody2D


const NORMAL = Vector2(0, -1)

export var friction = 0.05
var rotation_transform = Transform2D.IDENTITY
var rotation_transform_inv = Transform2D.IDENTITY.inverse()
var velo = Vector2()

onready var state_machine = $StateMachine


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var tmp_velo = state_machine.update_movement(rotation_transform_inv * velo)
	tmp_velo.x = lerp(tmp_velo.x, 0, friction)
	velo = move_and_slide(rotation_transform * tmp_velo, rotation_transform * NORMAL)


func rotate_transform(amount : float) -> void:
	rotation_transform = rotation_transform.rotated(amount)
	rotation_transform_inv = rotation_transform.inverse()
