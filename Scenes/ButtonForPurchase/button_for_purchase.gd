extends ButtonPar
class_name ButtonForPurchase

var purchase: PurchaseComponent

func _ready() -> void:
	await G.main_ready
	button_hitted.connect(_on_button_hitted)
	button_accepted.connect(_on_button_accepted)
	set_price()
	
func set_price() -> void:
	if purchase:
		purchase.current_price = purchase.divide_price(hit_buffer)
	
func is_hitted() -> bool:
	return purchase.try_to_pay()
	
func pay() -> void:
	purchase.pay()
	purchase.current_price += purchase.divide_price(hit_buffer)

func lvl_up() -> void:
	purchase.price += 10
	purchase.pay()
	set_price()
	
func _on_button_hitted(v: int) -> void:
	pay()
	
func _on_button_accepted() -> void:
	lvl_up()
