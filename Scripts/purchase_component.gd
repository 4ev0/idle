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
	return get_currecny(currency) >= current_price

func pay() -> void:
	match currency:
		G.Currencies.DOLLAR:
			G.cash -= current_price
		_:
			var ck: CircleContainer = G.get_n("circle_container")
			ck.merge_circles(ck.get_type_from_str(G.Currencies.keys()[currency]))
	
	purchased.emit()


func get_currecny(type: G.Currencies = currency) -> int:
	match type:
		G.Currencies.DOLLAR:
			return G.cash
		_:
			var ck: CircleContainer = G.get_n("circle_container")
			if ck:
				return ck.get_circle_count(ck.get_type_from_str(G.Currencies.keys()[type]))
	
	return 0
	
func get_currency_sign(type: G.Currencies = currency) -> String:
	match type:
		G.Currencies.DOLLAR:
			return "$"
		_:
			return "o"
	
	return ""
