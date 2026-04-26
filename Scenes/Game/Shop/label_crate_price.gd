extends Label
class_name LabelCratePrice

static var product_manager: ShopProductManager

func _ready() -> void:
	product_manager.reserved_cash_updated.connect(_on_reserved_cash_updated)

func _on_reserved_cash_updated(v: int) -> void:
	text = "$%d" %v
	#text = "$%d" %(int(text.substr(1)) + price)
	#text = "$%d" %(int(text.substr(1)) - price)
