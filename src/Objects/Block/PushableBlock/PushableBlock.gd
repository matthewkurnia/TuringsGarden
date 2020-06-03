extends GravityObject


export var push_speed = 200
export var accel = 0.5
var player = null


func _ready():
	$PlayerDetect/CollisionPolygon2D.polygon = extend_polygon_x($CollisionPolygon2D.polygon, 2)


func extend_polygon_x(polygon: PoolVector2Array, ammount: float) -> PoolVector2Array:
	var result_polygon = PoolVector2Array()
	for point in polygon:
		if point.x != 0:
			point.x += sign(point.x) * ammount
			result_polygon.append(point)
	return result_polygon


func _physics_process(delta):
	if player:
		velo.x = lerp(velo.x, sign(self.global_position.x - player.global_position.x) * push_speed, accel)
	else:
		velo.x = lerp(velo.x, 0, accel)


func _on_PlayerDetect_body_entered(body):
	if body.name == "Player":
		player = body


func _on_PlayerDetect_body_exited(body):
	if body.name == "Player":
		player = null
