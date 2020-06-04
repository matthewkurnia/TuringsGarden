extends Area2D


var picked_up_orb = null
var overlapped_orb = null
var slot = null


func _ready():
	pass # Replace with function body.


func _input(event):
	if Input.is_action_just_pressed("interact"):
		if overlapped_orb and not picked_up_orb:
			picked_up_orb = overlapped_orb
			picked_up_orb.pick_up(owner)
			return
		if slot and picked_up_orb:
			if picked_up_orb.drop(slot):
				picked_up_orb = null
			return


func _on_area_entered(area):
	if area.is_in_group("orb"):
		overlapped_orb = area
	if area.is_in_group("orb_slot"):
		slot = area


func _on_area_exited(area):
	if area.is_in_group("orb"):
		overlapped_orb = null
	if area.is_in_group("orb_slot"):
		slot = null
