extends Node2D
class_name HitCircle

func _ready() -> void:
	var tw: Tween = create_tween()
	tw.tween_property(self, "scale", Vector2.ZERO, 0.2).set_ease(Tween.EASE_OUT)
	await tw.finished
	queue_free()
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, 2, Color.WHITE)
	
