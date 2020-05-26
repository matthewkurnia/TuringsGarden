class_name State
extends Node


signal finished(next_state_name)


# Initialize the state. E.g. change the animation
func enter():
	return


# Clean up the state. Reinitialize values like a timer
func exit():
	return


func update_movement(velo: Vector2):
	return


func on_animation_finished(anim_name):
	return


func get_input_direction():
	return int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

