extends GridContainer
class_name ShopProductManager

@export var products: Dictionary = {}
@onready var types: Array = CircleManager.CircleTypes.keys()
@onready var purchased_circles: Dictionary[CircleManager.CircleTypes, int] = {}
@onready var circle_manager: CircleManager = G.get_n("circle_manager")
var reserved_cash: int = 0:
	set(v):
		if reserved_cash == 0 && v > reserved_cash:
			res_cash_setted.emit()
		if v == 0:
			res_cash_unsetted.emit()
			
		reserved_cash = v
		reserved_cash_updated.emit(v)

signal purchased(amount: int, type: CircleManager.CircleTypes, price: int)
signal returned(amount: int, type: CircleManager.CircleTypes, price: int)
signal reserved_cash_updated(v: int)
signal purchased_circles_updated(type: CircleManager, amount: int)
signal res_cash_setted
signal res_cash_unsetted
signal paid

func _enter_tree() -> void:
	ButtonShopCircleBuy.product_manager = self
	LabelCratePrice.product_manager = self

func _ready() -> void:
	for i in range(1, CircleManager.CircleTypes.size()):
		purchased_circles[i] = 0
		
	for i in get_children():
		if i.circle_type == CircleManager.CircleTypes.NULL:
			continue
		
		products[get_product_name(i.circle_type, i.circle_amount)] = i

	purchased.connect(_on_purchased)
	returned.connect(_on_returned)
	
func _on_purchased(amount: int, type: CircleManager.CircleTypes, price: int) -> void:
	purchased_circles[type] += amount
	reserved_cash += price
	purchased_circles_updated.emit(type, purchased_circles[type])
	
func _on_returned(amount: int, type: CircleManager.CircleTypes, price: int) -> void:
	purchased_circles[type] -= amount
	reserved_cash -= price
	purchased_circles_updated.emit(type, purchased_circles[type])

func get_purchased_circles(type: CircleManager.CircleTypes) -> int:
	return purchased_circles[type]

func get_product(type: CircleManager.CircleTypes, amount: int) -> ButtonShopCircleBuy:
	return products[get_product_name(type, amount)]
	
func get_product_name(type: CircleManager.CircleTypes, amount: int) -> String:
	return "%s%d" %[types[type], amount]

func change_product_state(type: CircleManager.CircleTypes, amount: int, _available: bool = true) -> void:
	get_product(type, amount).available = _available

func pay() -> void:
	G.cash -= reserved_cash
	reserved_cash = 0
	for i in purchased_circles:
		if purchased_circles[i] == 0:
			continue
			
		circle_manager.add_circles_to_crate(i, purchased_circles[i]) 
		purchased_circles[i] = 0
		purchased_circles_updated.emit(i, 0)

	paid.emit()
