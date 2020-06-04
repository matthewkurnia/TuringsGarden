class_name OrbSlot
extends Area2D


var active = false
var has_orb = false


func _ready():
	self.add_to_group("orb_slot")


func _process(delta): # Temporary, for debugging only
	if active:
		self.modulate = Color.black
	else:
		self.modulate = Color.white


func set_active(value: bool) -> void:
	active = value
