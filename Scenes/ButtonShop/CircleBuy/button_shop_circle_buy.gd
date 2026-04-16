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

signal available_changed(enabled: bool)
