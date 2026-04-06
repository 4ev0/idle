extends Particle
class_name ParticleCircleFlash

func _ready() -> void:
	setup_tw()
	scale = Vector2(0.2,0.2)
	tw.tween_property(self, "scale", Vector2.ONE, 0.25).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "scale", Vector2.ZERO, 0.15).set_ease(Tween.EASE_IN_OUT).set_delay(0.15)
	kill()

func _draw() -> void:
	draw_circle(Vector2.ZERO, 3, Color.WHITE)
