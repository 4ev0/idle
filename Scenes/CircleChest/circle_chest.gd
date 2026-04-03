extends Circle
class_name CircleChest

func die() -> void:
	print("chest broken")
	queue_free()
