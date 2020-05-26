extends Node


export var initial_state = NodePath()
var current_state

onready var state_map = {
	"idle": $Idle,
	"run": $Run,
	"jump": $Jump,
	"fall": $Fall,
	"pullinglever": $PullingLever,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	for state in get_children():
		state.connect("finished", self, "change_state")
	current_state = get_node(initial_state)
	current_state.enter()


func update_movement(velo: Vector2):
	return current_state.update_movement(velo)


func change_state(state_name: String):
	current_state.exit()
	current_state = state_map[state_name]
	current_state.enter()
