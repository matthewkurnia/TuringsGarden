extends Camera2D


export var speed = 0.1
var target = self


func _process(delta):
	self.global_position = self.global_position.linear_interpolate(target.global_position, speed)
#	self.global_position.x = lerp(self.global_position.x, target.global_position.x, speed)
#	self.global_position.y = lerp(self.global_position.y, target.global_position.y, speed)
	self.rotation = target.rotation


func get_camera_position():
	return self.global_position


func set_target(node: Node2D):
	target = node
