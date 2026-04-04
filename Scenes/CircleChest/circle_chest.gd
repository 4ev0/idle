extends Circle
class_name CircleChest

func die() -> void:
	G.chest_broken.emit()
	queue_free()
