extends Area2D


func get_collision_polygon() -> PoolVector2Array:
	return $CollisionPolygon2D.polygon


func offset_polygon(offset: Vector2, points: PoolVector2Array) -> PoolVector2Array:
	var offset_points = PoolVector2Array([])
	for point in points:
		offset_points.append(point + offset)
	return offset_points


func get_intersected_polygons():
	var intersected_polygons = []
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("duplicatable"):
			var poly1 = offset_polygon(self.global_position, get_collision_polygon())
			var poly2 = offset_polygon(body.global_position, body.get_collision_polygon())
			var poly3 = offset_polygon(-self.global_position, Geometry.intersect_polygons_2d(poly1, poly2)[0])
			intersected_polygons.append(poly3)
	return intersected_polygons
