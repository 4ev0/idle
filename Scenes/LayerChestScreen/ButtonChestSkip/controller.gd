extends ButtonController
class_name ButtonChestSkipController

func _on_button_accepted() -> void:
	G.chest_closed.emit()
