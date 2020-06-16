extends KinematicBody2D


func set_sprite_texture(texture: ViewportTexture) -> void:
	$Sprite.texture = texture


func set_collision_polygon(polygons) -> void:
	for child in get_children():
		if child is CollisionPolygon2D:
			child.queue_free()
	for polygon in polygons:
		var new_polygon = CollisionPolygon2D.new()
		new_polygon.polygon = polygon
		self.add_child(new_polygon)
