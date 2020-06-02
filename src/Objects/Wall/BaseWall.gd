extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("duplicatable")


func get_collision_polygon():
	return $CollisionPolygon2D.polygon
