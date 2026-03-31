extends Node2DComponent
class_name CircleGraphics

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var texture_scale: Vector2 = texture_progress_bar.size

func _ready() -> void:
	if parent:
		if parent.randomize_color:
			texture_progress_bar.modulate = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),1)
		else:
			texture_progress_bar.modulate = parent.data.color
			
		texture_progress_bar.max_value = parent.data.hp
		texture_progress_bar.scale = parent.get_target_scale()
		parent.value_updated.connect(_on_value_updated)

func _on_value_updated(new_v: float) -> void:
	texture_progress_bar.value = new_v

func _draw() -> void:
	if parent:
		draw_circle(Vector2.ZERO, parent.radius, Color.BLACK, false)
