extends Node


export var initial_state = NodePath()
export var coyote_time_msec = 100
var current_state
var ct_after: float
var ct_before: float


onready var state_map = {
	"idle": $Idle,
	"run": $Run,
	"jump": $Jump,
	"fall": $Fall,
	"pullinglever": $PullingLever,
	"pushing": $Pushing,
	"pulling": $Pulling,
}


func _ready():
	for state in get_children():
		state.connect("finished", self, "change_state")
	current_state = get_node(initial_state)
	current_state.enter()


func update_movement(velo: Vector2):
	coyote_time_check()
	return current_state.update_movement(velo)


func change_state(state_name: String):
	print(state_name)
	current_state.exit()
	current_state = state_map[state_name]
	current_state.enter()


func coyote_time_check():
	if owner.is_on_floor():
		ct_before = OS.get_ticks_msec()
	if Input.is_action_just_pressed("jump"):
		ct_after = OS.get_ticks_msec()
	
	if OS.get_ticks_msec() - ct_before < coyote_time_msec and Input.is_action_just_pressed("jump"):
		change_state("jump")
	if OS.get_ticks_msec() - ct_after < coyote_time_msec and current_state.name == "fall":
		change_state("jump")
