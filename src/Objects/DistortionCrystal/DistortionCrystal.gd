extends Node2D


const TARGET_VIEWPORT = preload("SourceViewport.tscn")


func _ready():
	initialize_viewport()


func _physics_process(delta):
	$Projection.set_collision_polygon($Source.get_intersected_polygons())


func initialize_viewport() -> void:
	var viewport = TARGET_VIEWPORT.instance()
	var vp_rect = Rect2()
	for point in $Source.get_collision_polygon():
		vp_rect = vp_rect.expand(point)
	viewport.size = vp_rect.size
	viewport.world_2d = get_viewport().world_2d
	viewport.set_camera_position($Source.global_position)
	Global.get_current_root().call_deferred("add_child", viewport)
	$Projection.set_sprite_texture(viewport.get_texture())