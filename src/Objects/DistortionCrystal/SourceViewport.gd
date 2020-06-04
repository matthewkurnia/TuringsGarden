extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_camera_position(global_pos: Vector2) -> void:
#	set_canvas_transform(Transform2D(0.0, -global_pos))
	$Camera2D.global_position = global_pos
