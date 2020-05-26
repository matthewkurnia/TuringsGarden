extends State


export var max_speed = 400.0
export var acceleration = 30.0


func update_movement(velo):
	if get_input_direction() == 0:
		emit_signal("finished", "idle")
	if Input.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	if not owner.is_on_floor():
		emit_signal("finished", "fall")
	
	var x = velo.x + get_input_direction() * acceleration
	x = min(x, max_speed) if x > 0 else max(x, -max_speed)
	
	return Vector2(x, velo.y + 10)
