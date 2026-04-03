extends Node
class_name PurchaseComponent

var parent: Node
@export var currency: G.Currencies
@export var price: float:
	set(v):
		price = v

var current_price: int = 0:
	set(v):
		current_price = v
		price_updated.emit(current_price)

signal price_updated(p: int)
signal purchased()

func divide_price(parts: int, _price: float = price) -> int: 
	return round(_price / parts)

func try_to_pay() -> bool:
	return G.get_currecny(currency) >= current_price

func pay() -> void:
	match currency:
		G.Currencies.DOLLAR:
			G.cash -= current_price
		_:
			var ck: CircleContainer = G.get_n("circle_container")
			ck.merge_circles(ck.get_type_from_str(G.Currencies.keys()[currency]))
