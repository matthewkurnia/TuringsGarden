extends Node


func get_current_root() -> Node:
	return get_tree().get_current_scene()
