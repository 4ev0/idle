extends ButtonForPurchaseController
class_name ButtonShopCircleBuyController

@onready var product_manager: ShopProductManager = parent.product_manager
static var circle_manager: CircleManager

func _ready() -> void:
	super()
	if parent.circle_type == 0:
		return
	
	#circle_manager.add_circles_to_crate(parent.circle_type, parent.circle_amount)

func is_hitted() -> bool:
	if G.tool_picked && parent.circle_type:
		match G.tool_picked:
			G.ShopToolTypes.MAGGLASS:
				pass
				
			G.ShopToolTypes.RETURN:
				var ctype: CircleManager.CircleTypes = parent.circle_type
				var camount: int = min(product_manager.get_purchased_circles(ctype), parent.circle_amount)
				if camount > 0:
					parent.returned.emit()
					var price: int = purchase.current_price if camount == parent.circle_amount else purchase.current_price / parent.circle_amount * camount
					product_manager.returned.emit(camount, ctype, price)
					#circle_manager.remove_circle_from_crate(ctype, camount)
				
		return false
		
	if purchase && parent.available:
		return G.cash - product_manager.reserved_cash > purchase.current_price
	
	return false

func set_price() -> void:
	purchase.current_price = purchase.price

func _on_button_accepted() -> void:
	product_manager.purchased.emit(parent.circle_amount, parent.circle_type, purchase.current_price)
	purchase.purchased.emit()
