extends AnimationTree


var anim_state_machine = get("parameters/playback")
var direction = 1
var advance_run = self["parameters/conditions/advance_run"]


onready var animated_sprite = owner.get_node("AnimatedSprite")


func _ready():
	owner.connect("direction_changed", self, "change_direction")
	anim_state_machine.call_deferred("start", "idle")
	set_process(false)


func _process(delta):
	animated_sprite.rotation_degrees = direction * min(abs(animated_sprite.rotation_degrees) + 0.3, 15)


func update_animation(anim_name: String) -> void:
	anim_state_machine.travel(anim_name)
	self["parameters/conditions/advance_run"] = anim_name == "run"
	if anim_name == "fall":
		set_process(true)
	else:
		set_process(false)
		animated_sprite.rotation_degrees = 0


func change_direction(new_dir):
	direction = new_dir
	if owner.is_on_floor():
		if anim_state_machine.get_current_node() in ["stop", "land"]:
			anim_state_machine.start("turn_run")
		else:
			anim_state_machine.start("turn_idle")
	else:
		anim_state_machine.start("turn_mid_air")


func update_flip():
	if direction > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	self.advance(0.1)
