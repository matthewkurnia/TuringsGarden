extends State


func update_movement(velo: Vector2):
	if get_input_direction() != 0:
		emit_signal("finished", "run")
	if Input.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	if not owner.is_on_floor():
		emit_signal("finished", "fall")
	
	return Vector2(velo.x, velo.y + 10)
