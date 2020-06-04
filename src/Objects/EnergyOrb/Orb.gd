class_name Orb
extends Area2D


enum states {
	PLACED,
	FOLLOW_PLAYER,
}

export var acceleration = 0.05
export var distance = 80.0
export var initial_slot = NodePath()

var current_state = states.PLACED
var player = null
var slot = null
var offset = Vector2(30.0, 0)


func _get_configuration_warning():
	if not initial_slot:
		return "Enter an initial slot for the orb"
	return ""


func _ready():
	self.add_to_group("orb")
	drop(get_node(initial_slot))


func _physics_process(delta):
	match current_state:
		states.PLACED:
			if not slot:
				return
			self.global_position = self.global_position.linear_interpolate(slot.global_position, 2 * acceleration)
			activate(slot)
		states.FOLLOW_PLAYER:
			if not player:
				return
			self.global_position = self.global_position.linear_interpolate(player.global_position + offset + Vector2(0, -distance), acceleration)


func _on_Timer_timeout():
	offset = offset.rotated(2 * PI * randf())


func pick_up(player_node):
	current_state = states.FOLLOW_PLAYER
	player = player_node
	slot.set_active(false)
	slot.has_orb = false


func drop(slot_node):
	if slot_node.has_orb:
		return false
	current_state = states.PLACED
	slot = slot_node
	slot.has_orb = true
	return true


func activate(slot_node):
	slot_node.set_active(true)
