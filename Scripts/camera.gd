extends Camera2D
class_name Camera

@onready var tree: SceneTree = get_tree()

func shake(intens: float, duration: float) -> void:
	var init_pos: Vector2 = position
	var t: float = duration
	
	while t > 0:
		var offset: Vector2 = Vector2(randf_range(-intens, intens), randf_range(-intens, intens))
		position = init_pos + offset
		t -= get_process_delta_time()
		await tree.process_frame
		
	position = init_pos
