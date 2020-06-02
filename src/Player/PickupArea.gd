extends Area2D


var object_picked_up = null


func _input(event):
	if event.is_action_pressed("pick_up"):
		pass


func pick_up(object):
	pass


func drop():
	pass


func _on_body_entered(body):
	if body.is_in_group("Pickable"):
		pass


func _on_body_exited(body):
	pass # Replace with function body.
