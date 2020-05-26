extends State


export var jump_strength = 1000.0
export var max_speed = 400.0
export var acceleration = 30.0
export var gravity = 30.0
var just_entered = false


func enter():
	just_entered = true


func update_movement(velo):
	if velo.y > 0:
		emit_signal("finished", "fall")
	
	var dynamic_jump_multiplier = 1.0
	dynamic_jump_multiplier *= 1 - 0.5 * int(Input.is_action_just_released("jump") and velo.y < 0)
	var x = velo.x + get_input_direction() * acceleration
	x = min(x, max_speed) if x > 0 else max(x, -max_speed)
	
	if just_entered:
		just_entered = false
		return Vector2(x, -jump_strength)
	return Vector2(x, velo.y * dynamic_jump_multiplier + gravity)
