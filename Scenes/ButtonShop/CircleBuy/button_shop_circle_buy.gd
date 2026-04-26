extends ButtonForPurchase
class_name ButtonShopCircleBuy

@export var circle_type: CircleManager.CircleTypes
@export var circle_amount: int
@export var available: bool = false:
	set(v):
		if available && v:
			return
			
		available = v
		available_changed.emit(available)

static var product_manager: ShopProductManager

signal available_changed(enabled: bool)
signal returned

func _ready() -> void:
	if available:
		available_changed.emit(available)
