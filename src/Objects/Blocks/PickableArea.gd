extends Area2D


signal interact


var player = null


func _ready():
	connect("interact", owner, "toggle_pick_up")


func _input(event):
	if event.is_action_pressed("interact"):
		emit_signal("interact", player)


func _on_body_entered(body):
	if body.name == "Player":
		player = body


func _on_body_exited(body):
	if body.name == "Player":
		player = null
