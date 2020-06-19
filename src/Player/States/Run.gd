extends State


var just_entered = false


func enter():
	just_entered = true


func update_movement(velo):
	if get_input_direction() == 0:
		emit_signal("finished", "idle")
	if Input.is_action_just_pressed("jump"):
		emit_signal("finished", "jump")
	if not owner.is_on_floor():
		emit_signal("finished", "fall")
	
	var x = velo.x + get_input_direction() * owner.acceleration
	
	if just_entered:
		just_entered = false
		return Vector2(0, velo.y + owner.gravity)
	return Vector2(x, velo.y + owner.gravity)
