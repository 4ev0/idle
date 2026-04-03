extends ButtonForPurchase
class_name ButtonMergeCircles

@onready var circle_container: CircleContainer = G.get_n("circle_container")
@export var type: CircleContainer.CircleTypes

func set_price() -> void:
	purchase.current_price = 2

func _on_button_hitted(v: int) -> void:
	pass
	
func _on_button_accepted() -> void:
	circle_container.merge_circles(type)
