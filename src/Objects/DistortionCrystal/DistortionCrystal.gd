extends Node2D


const TARGET_VIEWPORT = preload("SourceViewport.tscn")

var viewport :Viewport
onready var source = $Source
onready var projection = $Projection


func _ready():
	initialize_viewport()


func _physics_process(delta):
	projection.set_collision_polygon(source.get_intersected_polygons())
	viewport.set_canvas_transform(Transform2D(0, 0.5*viewport.size - source.global_position))
#	viewport.set_camera_position($Source.global_position)


func initialize_viewport() -> void:
	viewport = TARGET_VIEWPORT.instance()
	var vp_rect = Rect2()
	for point in source.get_collision_polygon():
		vp_rect = vp_rect.expand(point)
	viewport.size = vp_rect.size
	viewport.world_2d = get_viewport().world_2d
	viewport.set_camera_position(source.global_position)
	get_tree().get_root().call_deferred("add_child", viewport)
	projection.set_sprite_texture(viewport.get_texture())


func _on_tree_exiting():
	viewport.queue_free()
