extends ButtonForPurchaseController
class_name ButtonCircleBuy

@onready var manager: CircleManager = G.get_n("circle_manager")

func _ready() -> void:
	super()
	if parent.circle_type == 0:
		return
		
	purchase.purchased.connect(_on_purchased)

func _on_purchased() -> void:
	manager.add_circles_to_crate(parent.circle_type, parent.circle_amount)

func set_price() -> void:
	purchase.current_price = purchase.price

func pay() -> void:
	purchase.pay()

func _on_button_accepted() -> void:
	pay()
