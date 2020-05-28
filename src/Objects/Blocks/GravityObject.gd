class_name GravityObject
extends KinematicBody2D


var velo = Vector2()
var apply_gravity = true
export var gravity = 30.0
export var terminal_velo = 1000.0


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if apply_gravity:
		velo = move_and_slide(velo + Vector2(0, gravity), Vector2(0, -1))


func set_gravity(value: bool):
	apply_gravity = value
