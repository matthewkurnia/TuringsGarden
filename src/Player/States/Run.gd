extends State


func update_movement(velo):
	if get_input_direction() == 0:
		emit_signal("finished", "idle")
	if Input.is_action_just_pressed("jump"):
		emit_signal("finished", "jump")
	if not owner.is_on_floor():
		emit_signal("finished", "fall")
	
	var x = velo.x + get_input_direction() * owner.acceleration
	
	return Vector2(x, velo.y + owner.gravity)
