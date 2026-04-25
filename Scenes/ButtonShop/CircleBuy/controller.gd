extends ButtonForPurchaseController
class_name ButtonShopCircleBuyController

static var circle_manager: CircleManager
static var product_manager: ShopProductManager

func _ready() -> void:
	super()
	if parent.circle_type == 0:
		return
		
	purchase.purchased.connect(_on_purchased)

func _on_purchased() -> void:
	product_manager.purchased.emit(parent.circle_amount, parent.circle_type)
	circle_manager.add_circles_to_crate(parent.circle_type, parent.circle_amount)

func is_hitted() -> bool:
	if G.tool_picked && parent.circle_type:
		match G.tool_picked:
			G.ShopToolTypes.MAGGLASS:
				pass
				
			G.ShopToolTypes.RETURN:
				var ctype: CircleManager.CircleTypes = parent.circle_type
				var camount: int = min(circle_manager.circle_list[ctype], parent.circle_amount)
				if camount > 0:
					parent.returned.emit()
					product_manager.returned.emit(camount, ctype)
					circle_manager.remove_circle_from_crate(ctype, camount)
				
		return false
		
	if purchase && parent.available:
		return purchase.try_to_pay()
	
	return false

func set_price() -> void:
	purchase.current_price = purchase.price

func pay() -> void:
	purchase.pay()

func _on_button_accepted() -> void:
	pay()
