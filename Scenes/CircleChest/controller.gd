extends CircleController
class_name CircleChestController

func die() -> void:
	G.chest_broken.emit()
	parent.queue_free()
