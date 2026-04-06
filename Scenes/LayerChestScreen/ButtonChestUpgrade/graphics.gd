extends ButtonGraphicsProgress
class_name ButtonChestUpgradeGraphics

var tw: Tween

func _ready() -> void:
	super()
	progress_bar.modulate.a = 0

func _on_button_hitted(v: int) -> void:
	super(v)
	progress_bar.modulate.a = 0
	setup_tw()
	tw.tween_property(progress_bar, "modulate:a", 1, 0.2).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(progress_bar, "modulate:a", 0, 0.2).set_ease(Tween.EASE_IN_OUT)

func _on_button_accepted() -> void:
	progress_bar.value = progress_bar.max_value
	setup_tw()
	tw.tween_property(progress_bar, "modulate:a", 1, 0.2).set_ease(Tween.EASE_IN_OUT)
	await tw.finished
	parent.accept_animation_finished.emit()

func setup_tw() -> void:
	if tw:
		tw.kill()

	tw = create_tween()
	
