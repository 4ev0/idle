extends ButtonController
class_name ButtonChestUpgradeController

func _ready() -> void:
	super()
	if parent.graphics:
		parent.accept_animation_finished.connect(_on_accept_animation_finished)

func _on_accept_animation_finished() -> void:
	G.chest_closed.emit()

func _on_button_accepted() -> void:
	if parent.accept_animation_finished.has_connections():
		return
	
	G.chest_closed.emit()
	
