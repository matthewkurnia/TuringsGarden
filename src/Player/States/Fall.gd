extends State


export var gravity_multiplier = 0.95


func update_movement(velo):
	if owner.is_on_floor():
		if get_input_direction() == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "run")
	
	var x = velo.x + get_input_direction() * owner.acceleration
	
	return Vector2(x, min(velo.y + gravity_multiplier * owner.gravity, owner.terminal_velo))
