extends ButtonForPurchase
class_name ButtonAddCircle

@onready var circle_container: CircleContainer = G.get_n("circle_container")

func _on_button_accepted() -> void:
	super()
	circle_container.add_circle(circle_container.CircleTypes.WHITE)
