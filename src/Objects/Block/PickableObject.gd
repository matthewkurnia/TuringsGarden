class_name PickableObject
extends GravityObject


var picked_up = false
var just_dropped = false
var object_to_follow
export var follow_offset = Vector2(0, -100)
export var follow_speed = 0.1


func _ready():
	add_to_group("Pickable")


func _physics_process(delta):
	if picked_up:
		var target_location = object_to_follow.global_position + follow_offset
		self.global_position = self.global_position.linear_interpolate(target_location, follow_speed)
		return


func pick_up(object: Node2D):
	set_gravity(false)
	picked_up = true
	object_to_follow = object


func drop():
	set_gravity(true)
	picked_up = false
	just_dropped = true
