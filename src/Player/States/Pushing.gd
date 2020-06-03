extends State


func enter():
	owner.apply_friction = false


func exit():
	owner.apply_friction = true


func update_movement(velo):
	if get_input_direction() == 0:
		emit_signal("finished", "idle")
	if Input.is_action_just_pressed("jump"):
		emit_signal("finished", "jump")
	if not owner.is_on_floor():
		emit_signal("finished", "fall")
	
	return owner.push_pull_velo + Vector2(0, owner.gravity)
