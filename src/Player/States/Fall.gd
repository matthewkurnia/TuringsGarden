extends State


export var max_speed = 400.0
export var acceleration = 30.0
export var max_fall_speed = 800.0
export var gravity = 30.0


func update_movement(velo):
	if owner.is_on_floor():
		if get_input_direction() == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "run")
	
	var x = velo.x + get_input_direction() * acceleration
	x = min(x, max_speed) if x > 0 else max(x, -max_speed)
	
	return Vector2(x, min(velo.y + gravity, max_fall_speed))
