extends State


var just_entered = false


func enter():
	just_entered = true


func update_movement(velo):
	if velo.y > 0:
		emit_signal("finished", "fall")
	
	var dynamic_jump_multiplier = 1.0
	dynamic_jump_multiplier *= 1 - 0.5 * int(Input.is_action_just_released("jump") and velo.y < 0)
	var x = velo.x + get_input_direction() * owner.acceleration
	
	if just_entered:
		just_entered = false
		return Vector2(x, -owner.jump_strength)
	return Vector2(x, velo.y * dynamic_jump_multiplier + owner.gravity)
