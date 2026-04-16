extends HBoxContainer
class_name ShopToolManager

func _ready() -> void:
	G.state_changed.connect(_on_state_changed)
	
func _on_state_changed(state: G.GameStates) -> void:
	if state == G.GameStates.SHOP:
		for i in get_children():
			await get_tree().create_timer(0.3).timeout
			i.appear_required.emit()
	else:
		for i in get_children():
			i.hide()
