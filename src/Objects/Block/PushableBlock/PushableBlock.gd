extends GravityObject


export var accel = 0.5
export var speed = 300.0
var state = "idle"
var player = null


onready var push_area = $PushArea
onready var pull_area = $PullArea


func _ready():
	push_area.get_node("CollisionPolygon2D").polygon = extend_polygon_x($CollisionPolygon2D.polygon, 10)
	pull_area.get_node("CollisionPolygon2D").polygon = extend_polygon_x($CollisionPolygon2D.polygon, 30)


func _input(event):
	if Input.is_action_just_pressed("interact"):
		if player:
			if player.direction == sign(self.global_position.x - player.global_position.x):
				player.change_state("pulling")
				state = "pull"


func _physics_process(delta):
	match state:
		"idle":
			velo.x = 0
		"push":
			velo.x = sign(self.global_position.x - player.global_position.x) * speed
			player.push_pull_velo = velo
		"pull":
			var input_dir = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
			velo.x = input_dir * speed
			player.push_pull_velo = velo
			if Input.is_action_just_released("interact"):
				state = "idle"
				player.change_state("idle")


func extend_polygon_x(polygon: PoolVector2Array, ammount: float) -> PoolVector2Array:
	var result_polygon = PoolVector2Array()
	for point in polygon:
		if point.x != 0:
			point.x += sign(point.x) * ammount
			result_polygon.append(point)
	return result_polygon


func _on_PushArea_body_entered(body):
	if body.name == "Player":
		if state != "pull":
			state = "push"
			body.change_state("pushing")


func _on_PushArea_body_exited(body):
	if body.name == "Player":
		if state == "push":
			state = "idle"
			body.change_state("idle")


func _on_PullArea_body_entered(body):
	if body.name == "Player":
		player = body


func _on_PullArea_body_exited(body):
	if body.name == "Player":
		player = null
		state = "idle"
