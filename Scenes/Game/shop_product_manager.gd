extends GridContainer
class_name ShopProductManager

@export var products: Dictionary = {}
@onready var types: Array = CircleManager.CircleTypes.keys()

func _ready() -> void:
	for i in get_children():
		if i.circle_type == CircleManager.CircleTypes.NULL:
			continue
		
		products[get_product_name(i.circle_type, i.circle_amount)] = i

func get_product(type: CircleManager.CircleTypes, amount: int) -> ButtonShopCircleBuy:
	return products[get_product_name(type, amount)]
	
func get_product_name(type: CircleManager.CircleTypes, amount: int) -> String:
	return "%s%d" %[types[type], amount]

func change_product_state(type: CircleManager.CircleTypes, amount: int, _available: bool = true) -> void:
	get_product(type, amount).available = _available
