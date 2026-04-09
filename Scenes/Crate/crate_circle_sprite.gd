extends Sprite2D
class_name CrateCircleSprite

var tw: Tween

func _ready() -> void:
	tw = create_tween()
	tw.set_parallel()
	tw.tween_property(self, "position:y", -28, 0.35).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "scale", Vector2(1.15, 0.9), 0.26).set_ease(Tween.EASE_IN).set_delay
	tw.tween_property(self, "modulate:a", 0, 0.1).set_ease(Tween.EASE_OUT).set_delay(0.2)
	await tw.finished
	queue_free()
