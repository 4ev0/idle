extends Particle
class_name ParticleLines

var r: bool = false

func _ready() -> void:
	scale.x = 0
	tw = create_tween()
	tw.set_parallel()
	tw.tween_property(self, "scale:x", 1, 0.2).set_ease(Tween.EASE_IN)
	tw.tween_property(self, "position", move(5), 0.35).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "scale:x", 0, 0.3).set_ease(Tween.EASE_IN).set_delay(0.4)
	tw.tween_property(self, "position", move(10), 0.25).set_ease(Tween.EASE_OUT).set_delay(0.4)
	await tw.finished
	queue_free()

func move(xx: int = 0, yy: int = 0) -> Vector2:
	return position + Vector2(xx, yy).rotated(rotation)

func _draw() -> void:
	var sb: StyleBoxFlat = StyleBoxFlat.new()
	sb.set_corner_radius_all(2)
	sb.set_bg_color(Color.WHITE)
	sb.set_anti_aliased(false)
	var shadow: StyleBoxFlat = sb.duplicate()
	shadow.set_bg_color(Color.BLACK)
	draw_style_box(shadow, Rect2(-1,1,4,2))
	draw_style_box(shadow, Rect2(-1,-2,6,4))
	draw_style_box(sb, Rect2(0,-1,4,2))
