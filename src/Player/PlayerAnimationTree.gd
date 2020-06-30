extends AnimationTree


var anim_state_machine = get("parameters/playback")
var direction = 1


onready var animated_sprite = owner.get_node("AnimatedSprite")


func _ready():
	owner.connect("direction_changed", self, "change_direction")
	anim_state_machine.call_deferred("start", "idle")


func _process(delta):
	if anim_state_machine.get_current_node() == "jump":
		animated_sprite.rotation_degrees = owner.velo.x/owner.max_speed * 20
		return
	animated_sprite.rotation_degrees = lerp(animated_sprite.rotation_degrees, 0, 0.2)
	return
#	animated_sprite.rotation_degrees = direction * min(abs(animated_sprite.rotation_degrees) + 0.3, 15)


func update_animation(anim_name: String) -> void:
	anim_state_machine.travel(anim_name)


func change_direction(new_dir):
	direction = new_dir
	if owner.is_on_floor():
		if anim_state_machine.get_current_node() in ["stop", "land"]:
			anim_state_machine.start("turn_run")
		else:
			anim_state_machine.start("turn_idle")
	elif anim_state_machine.get_current_node() == "fall":
		anim_state_machine.start("turn_mid_air")
	else:
		update_flip()


func update_flip():
	if direction > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	self.advance(0.05)
