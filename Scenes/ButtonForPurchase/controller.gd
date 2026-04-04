extends ButtonController
class_name ButtonForPurchaseController

@onready var purchase: PurchaseComponent = parent.purchase

func _ready() -> void:
	super()
	set_price()

func is_hitted() -> bool:
	if purchase:
		return purchase.try_to_pay()
	
	return false

func _on_button_hitted(v: int) -> void:
	pay()

func _on_button_accepted() -> void:
	lvl_up()
	
func pay() -> void:
	purchase.pay()
	purchase.current_price += purchase.divide_price(parent.hit_buffer)

func lvl_up() -> void:
	purchase.price += 10
	purchase.pay()
	set_price()
	
func set_price() -> void:
	if purchase:
		purchase.current_price = purchase.divide_price(parent.hit_buffer)
