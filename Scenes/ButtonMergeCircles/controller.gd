extends ButtonForPurchaseController
class_name ButtonMergeCirclesController

@onready var circle_container: CircleContainer = G.get_n("circle_container")

func set_price() -> void:
	purchase.current_price = 2

func _on_button_hitted(v: int) -> void:
	pass

func _on_button_accepted() -> void:
	circle_container.merge_circles(parent.type)
